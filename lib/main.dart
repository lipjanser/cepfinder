import 'package:cepfinder/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

void main() => runApp(CepFinderApp());


/**
 * Author: lipjanser
 * Note: Pode utilizar como guia à vontade, só peço que não copie e cole.
 */
class CepFinderApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CEP FINDER 1.0',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends StateMVC<MyHomePage> {
  _MyHomePageState() : super(Controller());

  TextEditingController _textEditingController = TextEditingController(text: "");
  Future<dynamic> items;

  void _retrieveData() {
    setState(() {
      items = Controller.retrieveDataApi("${_textEditingController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CEP FINDER 1.0"),
        ),
        body: _buildScreen()
    );
  }

  Widget _buildScreen() {
    return Column(
      children: <Widget>[
        _buildSearchBar(),
        _buildAddressFields(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              labelText: "Pesquisa",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4),),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters:<TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
            maxLength: 8,
          ),
        ),
        RaisedButton(
          onPressed: () {
            if(_textEditingController.text.isEmpty) {
              print("Não pesquisou.");
            } else {
              _retrieveData();
            }
          },
          child: const Text(
              'Search',
              style: TextStyle(fontSize: 12)
          ),
        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Expanded(
        child: FutureBuilder(
          future: items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data["erro"] != true) {
                return Column(
                      children: <Widget>[
                        Column (
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("CEP: ")),
                              Text("${snapshot.data["cep"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Logradouro: ")),
                              Text("${snapshot.data["logradouro"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Complemento: ")),
                              Text("${snapshot.data["complemento"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Bairro: ")),
                              Text("${snapshot.data["bairro"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("Localidade/Cidade: ")),
                              Text("${snapshot.data["localidade"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("UF: ")),
                              Text("${snapshot.data["uf"]}"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text("IBGE: ")),
                              Text("${snapshot.data["ibge"]}"),
                            ],
                          ),
                        ]
                    )

                      ],
                    );
              } else {
                  return AlertDialog(
                            //title: new Text("Erro"),
                            content: new Text("CEP buscado não foi encontrado."),
                          );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }

}