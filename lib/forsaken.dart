import 'package:flutter/material.dart';
import "package:share/share.dart";
import 'dart:math';

class Hdd extends StatefulWidget{
  Hdd(this.index,front);
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
        onLongPress:() {front = !front;},
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

class CardTable extends StatelessWidget {

  final int cardColumnSize = 3; // temprory final

  @override
  Widget build(context) {
    return Container(
      color: Color.fromRGBO(100, 100, 100, 0.0),
      child: Center(
        child:Opacity(opacity: 1.0,
        child:Hero(
        tag:1,
        child: FlatButton(onLongPress: (){Navigator.pop(context);},
          onPressed: (){}, child: Text("egve4234r"))
        ),)
          
        
      )
  
      
    
    );

     //     (index) {
      //      
    //        return  Hdd(index,front);

     //       }  ; // itemBuilder
    
    } // Widget build
  } // Cards

class Card1 extends StatefulWidget {
  Card1(this.index,{Key key}) : super(key: key);
  final int index;

  Card1State createState() => Card1State(index);
}

class Card1State extends State<Card1                         >
  with TickerProviderStateMixin {
    Card1State(this.index);
    AnimationController controller;
    AnimationController controller1;
    Animation growAnimation;
    Animation qwer;
    Animation anim;
    
    int stack = 0;
    int index;
    int con = 0;
    double red = 0;
    
    bool front = true;
    bool ino = true;
    
  void tickfront() async {
    if(ino){
      red = red + 1;
      setState(() {
        
      });
    }
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

    anim = qwer;

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

    Widget fimg = Image.asset("images/bm_cards-" + str1 + ".png");
    Widget bimg = Image.asset("images/bm_cards-" + str2 + ".png");
    Widget inf = Center(child: TextSide());
    Widget wid;

    wid = fimg;

    return Container(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.005)
        ..rotateY(0)..scale(0.5 + 0.05*red)
        ..translate(0,0),
      child: GestureDetector(
        onTap: tickfront, 
        child: wid,
          
        )
      );
    } // Widget build
  } // CardState