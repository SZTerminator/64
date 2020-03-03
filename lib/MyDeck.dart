import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'CardPage.dart';
import 'package:flutter/services.dart';

class MyDeck extends StatefulWidget{
  MyDeck(this.deck);
  final Map deck;
  State<StatefulWidget> createState() => MyDeckState(deck);
}
class MyDeckState extends State<MyDeck>{
  MyDeckState(this.deck);
  List items = [];
  final Map deck;
  @override
  initState(){
    super.initState();
    rootBundle.loadString("text/0.json").then((value) {
      items = jsonDecode(value);
      setState(() {});
    });
    getData();
  }
  List decs;
  String path;
  getData() async {
    await getApplicationDocumentsDirectory().then((value) async {
      path = value.path;
      await File('$path/Decks.json').readAsString().then((value) {
        decs =  jsonDecode(value);
        setState(() {});
      });
    });
  }
  Future<void> alertDialogAddCard(context){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String name;
        return AlertDialog(
          title: Text("Добавить свою бизнесс модель"),
          content: Form(
            child: Column(
              children: <Widget>[
                Text("Название модели"),
                TextFormField(
                  onChanged: (value){
                    name = value;
                    setState(() {});
                  },
                  onSaved: (value){
                    name = value;
                    deck["name"] = name;
                    setState(() {});
                    Navigator.pop(context,deck);
                  },
                )
              ]
            )
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                deck["name"] = name;
                setState(() {});
                Navigator.pop(context,deck);
              }, 
              child: Text("Save")
            ),
          ],
        );
      }
    );
  }
  Widget build(context) {
    var size = MediaQuery.of(context).size;
    print(deck);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child:Column(children: <Widget>[
        Row(children: <Widget>[
          Text(deck["name"]),
          IconButton(icon: Icon(Icons.edit), 
          onPressed: (){
            alertDialogAddCard(context);
          })
        ],),
        Text("Main Card"),
        Container(
          height: size.height * 0.4,
         child:AspectRatio(
           aspectRatio: 756 / 1150,
           child: Image.asset(items[deck[0]["cards"][0]]["frontimage"]),)
        ),
        Text("Other Cards"),
        Container(
          height: 300,
          child: GridView.extent(
        padding: EdgeInsets.all(size.height*0.01),
        mainAxisSpacing: size.height*0.01,
        childAspectRatio: 756 / 1150,
        crossAxisSpacing: size.width*0.04,
        maxCrossAxisExtent: 189,
        children:List.generate(deck["cards"].length-1, (index) {
   return ClipRRect(
     borderRadius: BorderRadius.circular(15.0),
     child:Hero(
        tag: index, 
        child: GestureDetector(
          child:Image.asset(items[deck[0]["cards"][index+1]]["frontimage"]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) =>  CardPage(items[deck["cards"][index+1]],items[deck["cards"][index+1]]["cardnumber"])
            ));
          }
        )
        )
   );
        })
        )
        )
      ],),)
    );
  }
}