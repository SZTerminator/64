import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:share/share.dart";
import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'dart:async';                                                                                                                                                                                                                                                                                    
import 'package:flutter/foundation.dart';
import 'package:path_provider/''path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(BuildContext context) => MainScreen(),
        '/cardtable':(BuildContext context) => CardTable(),
        } // routes
      ), //MaterialApp
    ); // runApp
  } // main

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Test")
        ),
      body:Center(
        child:Container(
          width: 200.0,
          height: 300.0,
          child:Center(
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){Navigator.pushNamed(context, "/cardtable");},
                  child:Text("Cards")
                  ),
                RaisedButton(
                  onPressed: null,
                  child:Text("See My Workplace"),
                  ),
                RaisedButton(
                    onPressed: null,
                    child: Text("About Us")
                  ),
                RaisedButton(
                    onPressed: null,
                    child: Text("About Bisnes Models")
                  ),
                RaisedButton(
                  onPressed: null,
                  child: Text("About Navigators")
                  ),
                RaisedButton(
                  onPressed: null,
                  child: Text("Order a workshop")
                  ),
                ]
              ),
            ),
          ),
        ),
    //  backgroundColor: Color(0xff67f687),
      );
    }
  }

class CardTable extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CardTableState();
  }



class CardTableState extends State<CardTable> {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<Map> readCounter() async {
 
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return jsonDecode(contents);

  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }
  Widget build(context) {
    
    int items =1 ;
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(Icons.search), 
          onPressed: (){

setState((){
  items = items + 1;
});
          }) 
      ),
      extendBody: true,
      extendBodyBehindAppBar: false,
      primary: true,
      body: GridView.builder(
        itemCount: items,
        itemBuilder: (context,index){
          File f = _localFile;
          String a = f.readAsString().toString();
          Map df = jsonDecode(a);
          bool front = true; // TO DO add a button to change starting side & make it Stateful to change sides while running
          String str1 = df["frontimage"];
          String str2 = df["backimage"];
          String cur = front ? str1 : str2;
          bool ok = true;
          List sample;
          List depen = df["depen"];
          List sort = df["sort"];
          for(var n in sample){
            if(!depen.contains(n) & !sort.contains(n) ){
              ok = false;
            }
          }
          if(!ok){

          }

          return Hero(
            tag: index, 
            child: GestureDetector(
              child:Image.asset("images/bm_cards-$cur.png"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  CardPage(index)
                  )
                  );
                }
              )
            );
          },
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        )
      );
    }
  }


class CardPages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: List.generate(
        64, 
        (index){return Hero(
          tag: index,
          child: CardPage(index)
        )
         ;
          }
        ),
      );
    }
  }



class CardPage extends StatelessWidget{
  CardPage( this.index);
  final int index; // index shall be final

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(index),
        
      );
    }
  }

class Card extends StatefulWidget {
  Card(this.index,{Key key}) : super(key: key);
  final int index;

  CardState createState() => CardState(index);
}

class CardState extends State<Card>
  with TickerProviderStateMixin {
    CardState(this.index);
    AnimationController controller;
    AnimationController controller1;
    Animation growAnimation;
    Animation qwer;
    bool front = true;
    int stack = 0;
    int index;
    String text ;

  void tickfront() async {
    if(front){
    controller.forward();
    await new Future.delayed(Duration(milliseconds: 500), () {
      front = !front;
      setState(() {});
      controller1.reset();
      stack=1;controller1.forward();});}

    else if (!front){
      print("!front");
      
    }
    }

  void tickback() async {
    controller1.reverse();
    controller.reset();
    controller.forward();
    await new Future.delayed(Duration(milliseconds: 500), () {
      front = !front;
      setState(() {});
      stack=0;
      controller.reverse();});
    print("!232");
    }

  @override
  void initState() {
    super.initState();
    controller1 =
      AnimationController(vsync: this, duration: const Duration(milliseconds : 500))
      ..addListener(() {
        setState(() {});
        });
    controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds : 500))
        ..addListener(() {
          setState(() {});
          });
    qwer = Tween<double>(
      begin: 0.0, 
      end: 0.5)
      .animate(controller);

    growAnimation = Tween<double>(
      begin: 0.5, 
      end: 0.0)
      .animate(controller1);
    }

  @override
  Widget build(BuildContext context) {
    int img = index * 2 + 1;
    String f = img.toString();
   // String str1 = '0' * (3 - f.runes.length) + f;
    img++;
    f = img.toString();
    String str2 = '0' * (3 - f.runes.length) + f;

    Widget a = Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.005)
                ..rotateY(pi * qwer.value),
              alignment: Alignment.center,  
              child: FlatButton(
                onPressed: tickfront, 
                child: TextSide(),
                )
              );

      Widget b = Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.005)
                ..rotateY( -
                pi * growAnimation.value),
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: tickback, 
                child: Image.asset("images/bm_cards-" + str2 + ".png"),
                )
              );
      Widget current = front ? a : b;

    return  Center(
      child: GestureDetector(
                onTap: tickfront, 
                onSecondaryTapCancel: tickback,
                child: current,
                )
            
   
      );
    } // Widget build
  } // CardState



class TextSide extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    String text ;
    return Center(
      child: Column(
        children: <Widget>[
          Center(child:
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.share), 
              onPressed: () {Share.share(text);} ))),
          Text("StrategyCard.ru | Карты Бизнес-моделей 2018"),
          Text("Заголовок"),
          Text("description"),
          Text("Keys"),
          Text("Examples"),
          SelectableText("some text u can select")
          ]
        ),
      );
    }
  }