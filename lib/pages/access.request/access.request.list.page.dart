import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hcslzapp/components/button.dart';
import 'package:hcslzapp/components/centered.message.dart';
import 'package:hcslzapp/components/progress.dart';
import 'package:hcslzapp/controllers/access.request.controller.dart';
import 'package:hcslzapp/models/access.request.dart';
import 'package:asuka/asuka.dart' as asuka;

class AccessRequestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccessRequestListState();
  }
}

class AccessRequestListState extends State<AccessRequestList> {
  AccessRequestController _controller = AccessRequestController();

  @override
  void initState() {
    _controller.getFuture().then((value) {
      if (value != null && value.isNotEmpty) {
        _controller.hideButton();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => Scaffold(
          body: FutureBuilder<List<AccessRequest>>(
            future: _controller.future,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Progress();
                case ConnectionState.active:
                  break;
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return CenteredMessage(snapshot.error.toString());
                  } else {
                    if (snapshot.data == null)
                      return CenteredMessage(
                        _controller.errorMsg,
                      );
                    if (snapshot.data.length > 0) {
                      _controller.init;
                      _controller.accessRequests.addAll(snapshot.data);
                      return _buildListView();
                    } else
                      return CenteredMessage(
                        'Não existem requisições de acesso a serem aprovadas.',
                      );
                  }
              } //switch (snapshot.connectionState)
              return CenteredMessage(
                'Houve um erro desconhecido ao executar a transação.',
              );
            },
          ),
          floatingActionButton: _controller.isHideButton
              ? null
              : Button(icon: Icons.check, onClick: () => _check),
        ),
      );

  _buildListView() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white30, Colors.deepOrange],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: Observer(
          builder: (_) => ListView.separated(
            shrinkWrap: true,
            itemCount: _controller.accessRequests.length,
            itemBuilder: (_, int i) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white30,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(_controller.accessRequests[i].name),
                  subtitle: Text(_controller.accessRequests[i].email),
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                    backgroundColor: Colors.white,
                  ),
                  trailing: Wrap(
                    spacing: 10, // space between two icons
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.delete,
                          size: 25.0,
                        ),
                        onTap: () {
                          _controller.accessRequests.removeAt(i);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, int index) => const Divider(),
          ),
        ),
      );

  get _check {
    _controller.check().then(
          (value) {
        if (value != null) {
          asuka.showSnackBar(
            SnackBar(
              content: Text('Requisições de acesso autorizadas com sucesso.'),
            ),
          );
          Navigator.of(context).pop();
        } else {
          asuka.showSnackBar(
            SnackBar(
              content: Text(_controller.errorMsg),
            ),
          );
        }
      },
    );
  }
}