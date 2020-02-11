import 'package:flutter/material.dart';



class CardZoomState extends State<CardZoom>{
  CardZoomState(this.index);
  final int index;
  bool center = false;

  void zoom(){
InkWell()
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:"$index",
      child: CardIn(index),
    );
    }
  }



class CardZoom extends StatefulWidget{
  CardZoom(this.index);
  final int index;
  @override
  State<StatefulWidget> createState() {
    return null;
  }


  }

class _CardInState extends State<CardIn>{
  _CardInState(this.index);
  final int index;
  int stackImage = 0;

  void changeImage (){ 
    if (stackImage == 0){stackImage = 1;}
    else if (stackImage == 1){stackImage = 0;}
    setState(() {});
    }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: changeImage,
      child:IndexedStack(
        index:stackImage,
        children:<Widget>[
          Image.asset("images/$index"+"front.png"),
          Image.asset("images/$index"+"back.png")
          ]
        )
      );
    }
  }

class CardIn extends StatefulWidget {
  CardIn(this.index);
  final int index;
  @override
  _CardInState createState() => _CardInState(index);
  }

void addToMyDeck(int index){

  }

class CardFront extends StatelessWidget{
  CardFront( this.index);
  final int index;

  @override

  Widget build(BuildContext context) {
    print("CardFront was called");
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
      body: Center(child:CardIn(index)
        ),
      );
    }
  }

class Cards extends StatelessWidget {
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
        crossAxisCount: 2,
        children: List.generate(
          4,
          (index) {return  FlatButton(
            onPressed: (){
              print("OnPressed: Success");
              return CardFront(index);}, 
            child: Image.asset("images/$index"+"front.png"),
            );
            }, // itemBuilder
          ),
        ),
      );
    } // Widget build
  } // Cards

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
                  onPressed: (){Navigator.pushNamed(context, "/cards");},
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
 
void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(BuildContext context) => MainScreen(),
        '/cards':(BuildContext context) => Cards()
        } // routes
      ),
    ); // runApp
  } // void main()