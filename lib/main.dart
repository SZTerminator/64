import 'package:flutter/material.dart';
import "package:share/share.dart";
import 'dart:math';

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
  Widget build(context) {
    int items = 64;
    return Scaffold(
      
      extendBody: true,
      extendBodyBehindAppBar: false,
      primary: true,
      body: GridView.builder(
        itemCount: items,
        itemBuilder: (context,index){
          bool front = true; // TO DO add a button to change starting side & make it Stateful to change sides while running
          int img = index * 2 + 1;
          String f = img.toString();
          String str1 = '0' * (3 - f.runes.length) + f;
          img++;
          f = img.toString();
          String str2 = '0' * (3 - f.runes.length) + f;
          String cur = front ? str1 : str2;
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