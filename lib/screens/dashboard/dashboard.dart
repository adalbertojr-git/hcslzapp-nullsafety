import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hcslzapp/screens/associado/atualizar_associado.dart';
import 'package:hcslzapp/screens/boutique/lista_boutique.dart';
import 'package:hcslzapp/screens/carteira_digital/carteira_frente.dart';
import 'package:hcslzapp/screens/codigosDtc/codigos_dtc_tab.dart';
import 'package:hcslzapp/screens/documento/lista_documento.dart';
import 'package:hcslzapp/screens/evento/calendario_eventos.dart';
import 'package:hcslzapp/screens/financeiro/lista_mensalidades.dart';
import 'package:hcslzapp/screens/oficina/oficina_tab.dart';
import 'package:hcslzapp/screens/parceria/lista_parcerias.dart';
import 'package:hcslzapp/screens/role/meurole.dart';
import 'package:hcslzapp/screens/sobre/sobre.dart';

class Dashboard extends StatelessWidget {
  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Adalberto Jr.",
              ),
              accountEmail: Text("user@harleyclub.com"),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/imgs/passeio.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Sobre o HCSlz App"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: this._pinned,
            snap: this._snap,
            floating: this._floating,
            expandedHeight: 130.0,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Ola, Adalberto Jr",
                style:
                    new TextStyle(fontSize: 14.0, color: Colors.orangeAccent),
              ),
              background: Image.asset(
                'assets/imgs/passeio2.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),

          // If the main content is a list, use SliverList instead.
          SliverFillRemaining(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/imgs/hdlogo.png',
                    width: size.width,
                    height: size.height,
                  ),
                ),
                Center(
                  child: Container(
                    color: Colors.black12,
/*                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [Colors.white30, Colors.deepOrange],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                      ),
                    ),*/
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 20.0,
                      children: <Widget>[
                        GridButton(
                          title: "Meus Dados",
                          image: "assets/imgs/user.png",
                          index: 1,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AtualizarAssociado();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Meu Role",
                          image: "assets/imgs/maps.png",
                          index: 2,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MeuRole();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Financeiro",
                          image: "assets/imgs/financeiro.png",
                          index: 3,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ListaMensalidades();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Carteira Harley Club",
                          image: "assets/imgs/identidade.png",
                          index: 4,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CarteiraDigitalFrente();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Parcerias",
                          image: "assets/imgs/parcerias.png",
                          index: 5,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ListaParcerias();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Eventos",
                          image: "assets/imgs/eventos.png",
                          index: 6,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CalendarioEventos();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Codigos DTC",
                          image: "assets/imgs/codigosdtc.png",
                          index: 7,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CodigosDtcTab();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Oficina",
                          image: "assets/imgs/oficina.png",
                          index: 8,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return OficinaTab();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Boutique",
                          image: "assets/imgs/boutique.png",
                          index: 9,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ListaBoutique();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "Classificados",
                          image: "assets/imgs/classificados.png",
                          index: 10,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
/*                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Classificados();
                                },
                              ),
                            );*/
                          },
                        ),
                        GridButton(
                          title: "Documentos",
                          image: "assets/imgs/docs.png",
                          index: 11,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ListaDocumentos();
                                },
                              ),
                            );
                          },
                        ),
                        GridButton(
                          title: "O Harley Club",
                          image: "assets/imgs/logo.png",
                          index: 12,
                          context: context,
                          color: Colors.white10,
                          onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SobreHC();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GridButton extends StatelessWidget {
  GridButton(
      {this.title,
      this.image,
      this.index,
      this.context,
      this.color,
      this.onClick});

  final String title;
  final String image;
  final int index;
  final BuildContext context;
  final Color color;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: this.color,
      child: InkWell(
        onTap: () {
          onClick();
          //getItem(this.index);
        },
        splashColor: Colors.orange,
        child: Container(
          decoration: BoxDecoration(
              color: this.color,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 50.0,
                  color: Colors.deepOrange,
                )
              ]),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  } //build
} //GridButton
