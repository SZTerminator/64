import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

Future<void> alertDialogAddCustomDeck(context,File decksFile){
    var decs = jsonDecode(decksFile.readAsStringSync());
    String name = '';
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Name Your Deck"),
          content: Form(
            child: TextFormField(
              onChanged: (value){
                name = value;
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                decs.add([
                  {
                    "name" : name,
                    "description" : "",
                    "heading" : 0,
                    "cards" : []
                  }
                ]);
                decksFile.writeAsStringSync(jsonEncode(decs));
                return Navigator.pop(context, decs);
              }, 
              child: Text("Save")
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context, decs), 
              child: Text("Cancel")
            )
          ],
        );
      }
    );
  }