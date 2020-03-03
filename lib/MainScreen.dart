import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'CardTable.dart';

class MainScreen extends StatelessWidget{
  List decs;
  List items;
  getFileData() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;
    decs =  jsonDecode(File('$path/Decks.json').readAsStringSync());
    items = jsonDecode(await rootBundle.loadString("text/0.json").then((value) => value));
  }
  Widget build(BuildContext context) {
    getFileData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:Center(
        child:Container(
          color: Colors.white,
          width: size.width*0.6,
          height: size.height*0.3,
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => CardTable(items,decs)
                    )
                  ), // Navigator.push
                  child:Text("Cards")
                ),
                RaisedButton(
                  onPressed: () => launch("http://strategycards.ru/#contacts"),
                  child: Text("О Нас")
                ),
                RaisedButton(
                  onPressed: () => launch("http://strategycards.ru/"),
                  child: Text("About Bisnes Models")
                ),
                RaisedButton(
                  onPressed: () => launch("http://strategycards.ru/kazan-oct5-6"),
                  child: Text("About Navigators")
                ),
                RaisedButton(
                  onPressed: () => launch("http://strategycards.ru/kazan-oct5-6"),
                  child: Text("Order a workshop")
                ),
              ]
            ),
          ),
        ),
      ),
      backgroundColor: Colors.orangeAccent[50],
    );
  }
}