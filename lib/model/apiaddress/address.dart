import 'dart:convert';

import 'package:http/http.dart' as http;

class Address {

  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String unidade;
  final String ibge;
  final String gia;

  Address(
      {this.cep,
        this.logradouro,
        this.complemento,
        this.bairro,
        this.localidade,
        this.uf,
        this.unidade,
        this.ibge,
        this.gia});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        cep: json["cep"],
        logradouro: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
        unidade: json["unidade"],
        ibge: json["ibge"],
        gia: json["gia"]);
  }

  static Future<dynamic> retrieveDataWS(String searchtext) async {
    final response = await http.get("https://viacep.com.br/ws/$searchtext/json/");
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao tentar recuperar dados.");
    }
  }
}