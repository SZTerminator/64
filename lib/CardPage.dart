import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'Card.dart' as card;

class CardPage extends StatelessWidget{
  CardPage(this.items,this.index);
  final Map items;
  final int index;
  List examples = ["",""];
  String path;
  File examplesFile;
  Function read;
  Function write;
  Future<void> alertDialogAddExample(context){
    String a = "";
    String b = "";
    try {
      a = examples[0];
    } catch (e) {}
    try {
      b = examples[1];
    } catch (e) {}

    var reta = TextEditingController(text: a);
    var retb = TextEditingController(text: b);
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
    title: Text("Добавить свай проимер компании"),
    content: Form(
      child: Column(
        children: <Widget>[
          Text("Название компании"),
          TextFormField(      
            controller: reta,
          ),
          Text("Описание работы"),
          TextFormField(
            controller: retb,
          )
        ]
      )
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: (){
          examples = [reta.text,retb.text];
          write();
          Navigator.pop(context);
        }, 
        child: Text("Save")),
        FlatButton(
        onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("Cancel"))
    ],
  );
      }
    );
  }
  Widget build(BuildContext context) {
    getApplicationDocumentsDirectory().then((directory) {
      path = directory.path;
      examplesFile = File('$path/examples$index.json');
      read = () {return jsonDecode(examplesFile.readAsStringSync());};
      write = () {examplesFile.writeAsStringSync(jsonEncode(examples));};
    try {
      examples = read();
      write(examples);
    } 
    catch (e) {
      write();
    }
    }
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => alertDialogAddExample(context),
        tooltip: "Add my examples",
      ),
      backgroundColor: Colors.grey,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Text(jsonEncode(examples))
        ],)
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: card.Card(items,examples),
      ),
    );
  }
}