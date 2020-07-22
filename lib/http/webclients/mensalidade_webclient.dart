/*
Autor: Adalberto Jr.
App: HCSlz
Todos os direitos reservados ao Harley Club de Sao Luis
2020

Descriçao: classe que faz as chamadas aos metodos da Web API

Classe: Mensalidades

*/
import 'dart:convert';

import 'package:hcslzapp/models/mensalidade.dart';
import 'package:http/http.dart';

import 'webclient.dart';

/*
endereço URL da classe alvo
*/
const String moduloUrl = '/mensalidades';

class MensalidadeWebClient {
/*
retorna lista de todos as mensalidades pagas
*/
  Future<List<Mensalidade>> findAll() async {
    final Response response =
        await client.get(baseUrl + moduloUrl).timeout(Duration(seconds: 10));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Mensalidade.fromJson(json))
        .toList();
  }

/*
retorna lista com as mensalidades do associado especificado
params:
codigo: codigo do associado
*/
  Future<List<Mensalidade>> findByAssociado_Codigo(int codigo) async {
    final Response response = await client
        .get(baseUrl + moduloUrl + '/' + codigo.toString())
        .timeout(Duration(seconds: 10));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Mensalidade.fromJson(json))
        .toList();
  }
}
