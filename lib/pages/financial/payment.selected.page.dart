import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hcslzapp/components/button.dart';
import 'package:hcslzapp/components/centered.message.dart';
import 'package:hcslzapp/components/progress.dart';
import 'package:hcslzapp/components/input.textfield.dart';
import 'package:hcslzapp/controllers/payment.associated.controller.dart';
import 'package:hcslzapp/controllers/payment.selected.controller.dart';
import 'package:hcslzapp/models/payment.dart';
import 'package:hcslzapp/models/payment.months.dart';
import 'package:hcslzapp/repositories/payment.repo.dart';

class PaymentSelected extends StatefulWidget {
  final int paymentId;

  const PaymentSelected(this.paymentId);

  @override
  _PaymentSelectedState createState() => _PaymentSelectedState();
}

class _PaymentSelectedState extends State<PaymentSelected> {
  PaymentSelectedController _controller = PaymentSelectedController();

  @override
  void initState() {
    _controller.getFuture(widget.paymentId).then((value) {
      if (value != null && value.isNotEmpty) {
        _controller.hideButton();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      Observer(
        builder: (_) =>
            Scaffold(
              body: FutureBuilder<List<Payment>>(
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
                        return CenteredMessage(snapshot.error.toString());
                      } else {
                        if (snapshot.data == null)
                          return CenteredMessage(
                            _controller.errorMsg,
                          );
                        if (snapshot.data.length > 0) {
                          _controller.init;
                          print(snapshot.data);
                          _controller.payments.addAll(snapshot.data);
                          return _buildListView;
                        } else {}
                      }
                  } //switch (snapshot.connectionState)
                  return CenteredMessage(
                    'Houve um erro desconhecido ao executar a transação.',
                  );
                },
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
              floatingActionButton: _controller.isHideButton
                  ? null
                  : Button(
                icon: Icons.arrow_back,
                onClick: () => Navigator.of(context).pop(),
              ),
            ),
      );

  get _buildListView =>
      Container(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white30, Colors.deepOrange],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _controller.payments.length,
                itemBuilder: (_, i) {
                  var payments = List<Payment>.from(_controller.payments);
                  return _buildExpansionTile(payments, i);
                },
              ),
            ),
          ],
        ),
      );

  ExpansionTile _buildExpansionTile(List<Payment> payments, int i) =>
      ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          'Ano: ' + payments[i].year,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('Total pago: R\$ '),
        trailing: Wrap(
          spacing: 10, // space between two icons
          children: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.edit,
                size: 30.0,
              ),
              onTap: () {
              },
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children: payments[i].paymentMonths.map(_buildListTile).toList(),
          ),
        ],
      );

  ListTile _buildListTile(PaymentMonths paymentMonths) =>
      ListTile(
          leading: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 25,
          ),
          title: Text(
            'Mes: ' + paymentMonths.month.toString(),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Valor Pago: R\$ ' + paymentMonths.value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
      );
}
