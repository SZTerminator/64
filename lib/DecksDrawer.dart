import 'package:flutter/material.dart';
import 'AddDeck.dart';
import 'MyDeck.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';


class DecksDrawer extends StatefulWidget{
  DecksDrawer(this.decks);
  List decks;
  State<StatefulWidget> createState() => DecksDrawerState(decks);
}

class DecksDrawerState extends State<DecksDrawer>{
  
  DecksDrawerState(this.decks);
  List decks;
  File decksFile;

  getDecks(){
    try {
      decks =  jsonDecode(decksFile.readAsStringSync());
    } catch (e) {
      decks = [];
    }
    
    setState(() {});
  }
  getData() async {
    getApplicationDocumentsDirectory().then((value) {
      String path = value.path;
      decksFile = File('$path/Decks.json');
      getDecks();
      setState(() {});
    });
  }
  void initState() {
    super.initState();
    getData();
    //decksFile.writeAsString(jsonEncode(decs));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
        child:Container(
          child: ListView(
            children: List.generate(decks.length + 1, (index) {
              if (index == 0){
                return Row(
                  children: <Widget>[
                    Text("My Decks"),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: getDecks,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        alertDialogAddCustomDeck(context,decksFile);
                        getDecks();
                      }
                    )
                  ],
                );
              }
              else{
                return FlatButton(
                onPressed: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (condext) => MyDeck(decks[index-1][0])
                  )
                ), 
                child: Container(
                  width:  size.width*0.5,
                  height: size.height*0.1,
                  child: Text(
                    decks[index-1][0]["name"],
                    textAlign: TextAlign.center,
                  ),
                )
              );
              }
            })
          ),
        )
      );
  }

}