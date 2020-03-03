import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

Future<void> alertDialogAddCard(context, index,File customCardsFile){
    var name = TextEditingController(text: "");
    var short = TextEditingController(text: "");
    var long = TextEditingController(text: "");
    var keys = TextEditingController(text: "");
    var companies = TextEditingController(text: "");
    var casse = TextEditingController(text: "");
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Добавить свою бизнесс модель"),
          content: Form(
            child: Column(
              children: <Widget>[
                Text("Название модели"),
                TextFormField(
                  controller: name,
                ),
                Text("Коротко суть"),
                TextFormField(
                  controller: short,
                ),
                Text("Подробное описание"),
                TextFormField(
                  controller: long,
                ),
                Text("Ключи:"),
                TextFormField(
                  controller: keys,
                ),
                Text("Примеры компаний"),
                TextFormField(
                  controller: companies,
                ),
                Text("Описание примеров компаний"),
                TextFormField(
                  controller: casse,
                ),
              ]
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Map sh = {
                  "cardnumber": index,
                  "templates": [],
                  "sort": [],
                  "depen": [],
                  "title" : name.text,
                  "short description" : short.text,
                  "ful description" : long.text,
                  "keys" : keys.text.split("\n"),
                  "companies" : companies.text,
                  "case" : casse.text,
                };
                var customCards = jsonDecode(customCardsFile.readAsStringSync());
                customCards.add(sh);
                customCardsFile.writeAsStringSync(jsonEncode(customCards));
                Navigator.pop(context);
              }, 
              child: Text("Save")
            ),
            FlatButton(
              onPressed: () => Navigator.pop(context), 
              child: Text("Cancel")
            )
          ],
        );
      }
    );
  }