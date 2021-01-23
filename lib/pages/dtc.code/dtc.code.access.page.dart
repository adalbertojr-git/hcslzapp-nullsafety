import 'package:flutter/material.dart';
import 'package:hcslzapp/components/button.dart';
import 'package:hcslzapp/pages/dtc.code/dtc.code.list.page.dart';

class DtcCodeAccess extends StatelessWidget {
  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white30, Colors.deepOrange],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: Form(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox (
                height: 20.0,
              ),
              Text(
                'Como acessar?',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildTexto(),
            ],
          )),
        ),
      ),
      floatingActionButton: Button(
        icon: Icons.search,
        onClick: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DtcCodeList();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTexto() {
    return RichText(
      text: TextSpan(
        text: 'Android Popup Menu displays the menu below the anchor text if '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'space is available otherwise above the anchor text. It '
            'disappears if you click outside the popup menu.\n\n',
        style: const TextStyle(color: Colors.black87),
        children: <TextSpan>[
          const TextSpan(text: 'The app was developed with '),
          TextSpan(
            text: 'Flutter',
            //recognizer: _flutterTapRecognizer,
            //style: linkStyle,
          ),
          const TextSpan(
            text: ' and it\'s open source; check out the source '
                'code yourself from ',
          ),
          TextSpan(
            text: 'www.codesnippettalk.com',
            //recognizer: _githubTapRecognizer,
            //style: linkStyle,
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}