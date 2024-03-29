import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hcslzapp/models/template.dart';
import 'package:hcslzapp/pages/password/forgot.password.page.dart';
import "../../models/associated.dart";
import '../../common/labels.and.hints.dart';
import '../../common/token.details.dart';
import '../../components/button.dart';
import '../../components/my.text.form.field.dart';
import '../../controllers/login.controller.dart';
import '../../models/token.dart';
import '../dashboard/dashboard.page.dart';
import 'package:asuka/asuka.dart' as asuka;
import '../access.request/access.request.add.page.dart';

const String _pathLogoImage = 'assets/imgs/logo.png';
const String _labelForgotPsw = 'Esqueceu a senha?';
const String _labelFirstAcc = 'Primeiro acesso?';

class LoginPage extends StatelessWidget {
  LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          body: _widgets(_),
        );
      },
    );
  }

  _widgets(BuildContext context) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white30, Colors.deepOrange],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                    child: Image.asset(_pathLogoImage),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  MyTextFormField(
                    textEditingController: _controller.userLoginCtrl,
                    label: labelUser,
                    hint: hintUser,
                    icon: Icons.person,
                    inputType: TextInputType.text,
                  ),
                  MyTextFormField(
                    textEditingController: _controller.pswLoginCtrl,
                    label: labelPsw,
                    hint: hintPsw,
                    icon: Icons.vpn_key,
                    inputType: TextInputType.text,
                    hidden: true,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Button(
                    icon: Icons.arrow_forward,
                    onClick: () {
                      _login(context);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          _labelForgotPsw,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccessRequestAddPage()),
                          );
                        },
                        child: Text(
                          _labelFirstAcc,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  _login(BuildContext context) {
    if (_controller.userLoginCtrl.text.length > 0 &&
        _controller.pswLoginCtrl.text.length > 0) {
      asuka.showSnackBar(
        SnackBar(
          content: Text('Carregando...'),
        ),
      );
      _controller.authenticate().then(
        (token) async {
          if (token == null) {
            asuka.showSnackBar(
              SnackBar(
                content: Text(_controller.errorMsg),
              ),
            );
          } else {
            Token _t = token;
            print(_t.token);
            Associated associated = Template().loadAssociated();
            _controller.setTokenToDevice(_t.token);
            _controller.setUserToDevice(_controller.userLoginCtrl.text);
            TokenDetails _tokenDetails = TokenDetails(_t.token);
            await _controller.findByIdToList(_tokenDetails.associatedId()).then(
              (value) {
                associated = value[0];
              },
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardPage(
                  //_controller.associated,
                  associated,
                ),
              ),
            );
          }
        },
      );
    }
  }
}
