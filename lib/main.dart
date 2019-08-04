import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Lista de tarefas
  List _toDoList = [
    {"title": "Aprender Flutter", "ok": true},
    {"title": "Aprender Dart", "ok": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                String itemTitle = _toDoList[index]["title"];
                bool itemCheck = _toDoList[index]["ok"];

                return CheckboxListTile(
                  title: Text(itemTitle),
                  value: itemCheck,
                  secondary: CircleAvatar(
                    child: Icon(itemCheck ? Icons.check : Icons.error),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Obter aquivo
  Future<File> _getFile() async {
    // Obtem o diretorio de armazenamento do IOS/Android
    final directory = await getApplicationDocumentsDirectory();
    // Obtem o arquivo json do dispositivo
    return File("${directory.path}/data.json");
  }

  /// Salva o arquivo
  Future<File> _saveData() async {
    // Transforma os objetos em JSON
    String data = json.encode(_toDoList);
    // Busca o arquivo data.json do dispositivo para gravar o JSON
    final file = await _getFile();
    // Grqava o json no arquivo data.json
    return file.writeAsString(data);
  }

  /// Lê o arquivo
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
