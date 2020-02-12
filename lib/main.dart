import 'package:flutter/material.dart';
import "package:share/share.dart";
import 'dart:math';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(BuildContext context) => MainScreen(),
        '/cardtable':(BuildContext context) => CardTable()
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
 

class CardTable extends StatelessWidget {

  final int cardColumnSize = 2; // temprory final

  @override
  Widget build(context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children:
        <Widget>[
          FlatButton(
            child: Text("MyDecs"),
            onPressed: (){Navigator.pop(context);},
            ),
          ]
        ),
      ),
      appBar: AppBar(
        title: FlatButton(
          onPressed: (){Navigator.pop(context);},
          child: Text("test")
          ),
        ),
      body: GridView.count(
        crossAxisCount: cardColumnSize,
        children: List.generate(
          64,
          (index) {
            bool front = true; // TO DO add a button to change starting side & make it Stateful to change sides while running
            int img = index * 2;
            String f = img.toString();
            String str1 = '0' * (3 - f.runes.length) + f;
            img++;
            f = img.toString();
            String str2 = '0' * (3 - f.runes.length) + f;
            String show = front ? str1 : str2;
            Widget der = Image.asset("images/bm_cards-$show.png");
            return  Hdd(index,front);
            }, // itemBuilder
          ),
        ),
      );
    } // Widget build
  } // Cards

class Hdd extends StatefulWidget{
  Hdd(this.index,this.front);
  final int index;
  bool front;

  @override
  State<StatefulWidget> createState() => Hddstate(index,front);
}

class Hddstate extends State<Hdd>{
  Hddstate(this.index,this.front);
  final int index;
  bool front;
  bool pos = true;
  @override
  Widget build(BuildContext context) {
    Widget imagefront = Image.asset("images/front");
    Widget imageback = Image.asset("images/back");
    Widget image1 = Container(
      child:AspectRatio(
      aspectRatio: 1 / 1.4426373 ,
      child: GestureDetector(
        onTap:() {front = !front;},
        child: front ? imagefront : imageback,
      ),
    ),);
    Widget image2 = Card(index);
    return Container(
      child: GestureDetector(
        onTap: (){pos = !pos;},
        child: pos ? image1 : image2,
      )
    ,);
  }
}

class CardPage extends StatelessWidget{
  CardPage( this.index);
  final int index; // index shall be final

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("text"),
            IconButton(
              icon: Icon(Icons.volume_down),
              onPressed: null // реализация одной функции заказчика
              ),
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: null // реализация одной функции заказчика
              ),
            ]
          )
        ),
      body: Card(index)
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

  void tickfront() async {
    controller.forward();
    await new Future.delayed(Duration(milliseconds: 500), () {stack=1;controller1.forward();});
    }

  void tickback() async {
    controller1.reverse();
    await new Future.delayed(Duration(milliseconds: 500), () {stack=0;controller.reverse();});
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
      end: 1.0)
      .animate(controller1);
    }

  @override
  Widget build(BuildContext context) {
    int img = index * 2;
    String f = img.toString();
    String str1 = '0' * (3 - f.runes.length) + f;
    img++;
    f = img.toString();
    String str2 = '0' * (3 - f.runes.length) + f;
    return  Center(
      child: 
        IndexedStack(
          index: stack,
          children:<Widget>[
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.005)
                ..rotateY(pi * qwer.value),
              alignment: Alignment.center,  
              child: FlatButton(
                onPressed: tickfront, 
                child: Image.asset("images/bm_cards-$str1.png"),
                )
              ),
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.005)
                ..rotateY(pi * growAnimation.value),
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: tickback, 
                child: Image.asset("images/bm_cards-$str2.png"),
                )
              ),
            ]
        ),
      );
    } // Widget build
  } // CardState