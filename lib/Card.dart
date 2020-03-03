import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:share/share.dart';

class Card extends StatefulWidget {
  Card(this.items,this.examples);
  final Map items;
  final List examples;
  CardState createState() => CardState(items,examples);
}
class CardState extends State<Card> with TickerProviderStateMixin {
  CardState(this.items,this.examples);
  AnimationController controller;
  int index;
  AnimationController controller1;
  Animation sec;
  Animation qwer;
  Animation animation;
  bool front = true;
  bool anim_active = false;
  Map items;
  List examples;
  String text;
  String path = '/data/user/0/com.example.app64cards/app_flutter/';
  File decksFile;
  File examplesFile;
  List decs = [];
  List example = [];
  Function readEx;
  Function writeEx;
  Function readDe;
  Function writeDe;
  Future readFiles() async {
    path = await getApplicationDocumentsDirectory().then((directory) => directory.path);
    examplesFile = File('$path/examples$index.json');
    decksFile = File('$path/Decks.json');
    readDe = () => jsonDecode(decksFile.readAsStringSync());
    readEx = () => jsonDecode(examplesFile.readAsStringSync());
    writeEx = () {examplesFile.writeAsStringSync(jsonEncode(examples));};
    writeDe = () {decksFile.writeAsStringSync(jsonEncode(decs));};
    try {
      examples = readEx();
      writeEx();
    } 
    catch (e) {
      writeEx();
    }
    try {
      decs = readDe();
      writeDe();
    } 
    catch (e) {
      writeDe();
    }
  }
  Future<void> addToCustomDeck(){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Where?"),
          children: List.generate(
            decs.length+1, (num) {
              if (num == 0){
                return SimpleDialogOption(
                  child: Text("New"),
                  onPressed:(){
                    decs.add({
                      "name" : "New Deck",
                      "description" : "",
                      "heading" : items["cardnumber"],
                      "cards" : [items["cardnumber"]]
                    });
                    writeDe();
                    Navigator.pop(context, decs);
                  },
                );
              }
              else{
                return SimpleDialogOption(
                  onPressed: (){
                    if(decs[num-1]["cards"].contains(index)){
                      decs[num-1]["cards"].remove(index);
                    }
                    else {
                      decs[num-1]["cards"].add(index);
                    }
                    decksFile.writeAsStringSync(jsonEncode(decs));
                    Navigator.pop(context, decs);
                  }, 
                  child: Text(decs[num-1]["name"]),
                );
              }
            }
          )
        );
      }
    );
  }
  void flip() async {
    if(!anim_active) // to do:u remove this
    {
      if(front){
      anim_active = !anim_active;
      controller.forward();
      controller1.reset();
      await new Future.delayed(Duration(milliseconds: 350), () {
        front = !front;
        animation = front ? qwer : sec;
        setState(() {});
        
        controller1.forward();});
        await new Future.delayed(Duration(milliseconds: 350), () {
        
        anim_active = !anim_active;
        });
        }
    else if (!front){
      anim_active = !anim_active;
    controller1.reverse();
    controller.reset();
    controller.forward();
    await new Future.delayed(Duration(milliseconds: 350), () {
      front = !front;
      animation = !front ? qwer : sec;
      setState(() {});
      controller.reverse();});
    await new Future.delayed(Duration(milliseconds: 350), (){
      anim_active = !anim_active;

    });
    }

    }
    }
  void initState() {
    super.initState();
    index = items["cardnumber"];
    readFiles();
    String keys = '';
    for (var item in items["keys"]) {
      keys = keys + item + "\n";
    }
    text = "StrategyCard.ru | Карты Бизнес-моделей 2018\n" + items["title"] + "\n" + items["short description"] + "\n" + items["ful description"] + "\n" + keys  + "\n" +  items["case"];
    controller1 =
      AnimationController(vsync: this, duration: Duration(milliseconds : 350))
      ..addListener(() {
        setState(() {});
        });
    controller =
      AnimationController(vsync: this, duration: Duration(milliseconds : 350))
        ..addListener(() {
          setState(() {});
          });
    qwer = Tween<double>(
      begin: 0.0, 
      end: 0.5)
      .animate(controller);

    sec = Tween<double>(
      begin: 0.5, 
      end: 0.0)
      .animate(controller1);
    }
  
  Widget build(BuildContext context) {
    animation = front ? qwer : sec;
    double angle = front ? pi : -pi;
    return  Center(
      child: GestureDetector(
        onTap: flip,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.005)
            ..rotateY(angle * animation.value),
          alignment: Alignment.center,  
          child: FlatButton(
            onPressed: flip, 
            child: Stack(
              children: <Widget>[
                FractionallySizedBox(
                  heightFactor: 0.6,
                  child: AspectRatio(
                    aspectRatio: 756 / 1150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: front ? Image.asset("images/${items["cardnumber"]}-front.png"): //TextSide(items, index) : 
                        Image.asset("images/${items["cardnumber"]}-back.png"),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 30,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        iconSize: 15,
                        onPressed:() {
                          Share.share(text);
                        },
                        icon: Icon(Icons.share),
                      ),
                      IconButton(
                        iconSize:  15,
                        icon: Icon(Icons.add), 
                        onPressed: addToCustomDeck,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ); // Center
  } // Widget build
} 