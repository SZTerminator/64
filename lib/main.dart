import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import "package:share/share.dart";
import 'dart:math';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ), //MaterialApp
  ); // runApp
} // main
class MainScreen extends StatelessWidget{

  List decs = [];

    Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/Decks.json');
  }
  Future readCustomDecks() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    decs =  jsonDecode(contents);
  }
  List items;
  getFileData() async {
    String b = await rootBundle.loadString("text/0.json").then((value) => value);
    items = jsonDecode(b);
  }
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getFileData();
    readCustomDecks();
    return Scaffold(
      body:Center(
        child:Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width*0.6,
          height: MediaQuery.of(context).size.height*0.3,
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) =>  CardTable(items,decs)
                      )
                    ); 
                  },
                  child:Text("Cards")
                ),
                RaisedButton(
                  onPressed: (){launch("http://strategycards.ru/#contacts");},
                  child: Text("О Нас")
                ),
                RaisedButton(
                  onPressed: (){launch("hhttp://strategycards.ru/");},
                  child: Text("About Bisnes Models")
                ),
                RaisedButton(
                  onPressed: (){launch("http://strategycards.ru/kazan-oct5-6");},
                  child: Text("About Navigators")
                ),
                RaisedButton(
                  onPressed: (){launch("http://strategycards.ru/kazan-oct5-6");},
                  child: Text("Order a workshop")
                ),
              ]
            ),
          ),
        ),
      ),
      backgroundColor: Colors.orangeAccent[50],
    );
  }
}
class CardTable extends StatefulWidget{
  CardTable(this.items,this.decs);
  final List decs;
  final List items;
  @override
  State<StatefulWidget> createState() => CardTableState(items, decs);
  }
class CardTableState extends State<CardTable> {
  CardTableState(this.items,this.decs);
  final List items;
  List decs;

  List a = [];

  List sorts = [1,2,3,4,5,6,7,8,9,10];
  final List sort = [1,2,3,4,5,6,7,8,9,10];
  List<bool> ccc = [true,true,true,true,true,true,true,true,true,true,];

  List rpvs = ["R1","R2","R3","R4","P1","P2","P3","P4","V1","V2","V3","V4"];
  final List rpv = ["R1","R2","R3","R4","P1","P2","P3","P4","V1","V2","V3","V4"];
  List<bool> RPV = [true,true,true,true,true,true,true,true,true,true,true,true];

  List temps = [1,2,3,4,5,6,7,8,9];
  final List temp = [1,2,3,4,5,6,7,8,9];
  List<bool> tempActive = [true,true,true,true,true,true,true,true,true];
  
  List numbersToolTips =["Бизнес-модель", "Сеть", "Структура", "Процесс", "Совершенствование продукта", "Продуктовая система", "Сервис", "Канал" , "Бренд", "Участие клиента"];
  List lettersToolTips = ["Ресурсы -  Разнообразие (увеличение + / сокращение -)","Ресурсы - Границы (установление + / стирание -)","Ресурсы - Скорость (увеличение + / снижение -)","Ресурсы - Гибкость (повышение + / сокращение -)", "Процессы — Разнообразие (увеличение + / сокращение -)", "Процессы — Границы (установление + / стирание -)", "Процессы — Скорость (увеличение + / снижение -)", "Процессы — Гибкость (повышение + / сокращение -)","Ценности — Разнообразие (увеличение + / сокращение -)","Ценности — Границы (установление + / стирание -)","Ценности — Скорость (увеличение + / снижение -)","Ценности — Гибкость (повышение + / сокращение -)"];

  Color col;
  Color color_rpv;

  bool front = true;
  String image;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/Decks.json');
}
  Future<File> writeCounter(List decs) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(decs));
  }
  Future readCounter() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    decs =  jsonDecode(contents);
    setState(() {});
  }
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    for (var item in items) {
      a.add(item);
      }
    setState(() {});
  }
  Future<void> alertDialogAddCard(context){
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
          TextFormField(),
          Text("Коротко суть"),
          TextFormField(),
          Text("Подробное описание"),
          TextFormField(),
          Text("Ключи: "),
          TextFormField(),
          Text("Примеры компаний"),
          TextFormField(),
        ]
      )),
    actions: <Widget>[
      FlatButton(
        onPressed: null, 
        child: Text("Save")),
        FlatButton(
        onPressed: null, 
        child: Text("Cancel"))
    ],
  );
      }
      );

  }
  changeTableDeck(){
    a = [];
    List intersection = [];
    List association = [];

    bool inter = true;
    bool ok = false;

    for (var item in items) {
      inter = true;
      for (var _sort in sorts) {
        if(!item["depen"].contains(_sort)){
          inter = false;
        }
        else{
          ok = true;
        }
      }
      for (var _rpv in rpvs) {
        if(!item["sort"].contains(_rpv + '+') ^ 
        !item["sort"].contains(_rpv + '-') ^ 
        !item["sort"].contains(_rpv + '+' + _rpv + "-")){
          inter = false;
        }
        else{
          ok = true;
        }
      }
      for (var _temp in temps) {
        if(!item["templates"].contains(_temp)){
          inter = false;
        }
        else{
          ok = true;
        }
      }
      if(inter){
        intersection.add(item);
        continue;
      }
      if (ok){
        association.add(item);
      }
    }
    intersection.addAll(association);
    a.addAll(intersection);
  }
  Widget build(context) {
    image = front ? "frontimage" : "backtimage";
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){alertDialogAddCard(context);},
        tooltip: "Add my examples",
        ),
      backgroundColor: Colors.brown,
      endDrawer: Drawer(
        child:Container(
          child: ListView(
          children: List.generate(
              decs.length + 1,
               (index){
                 if (index == 0){
                   return Row(children: <Widget>[
                     Text("My Decks"),
                     IconButton(
                       icon: Icon(Icons.refresh),
                       onPressed: (){
                         readCounter();
                       })
                   ],);
                 }
              return FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (condext) => MyDeck(items,decs[index-1])));
                }, 
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height:MediaQuery.of(context).size.height*0.1,
                child: Text(decs[index-1]["name"],
                textAlign: TextAlign.center,),
                ));
            })
           
        ),)
      ),
      drawer: Opacity(
        opacity: 0.7,
        child: Drawer(
          child: Container(
            margin: EdgeInsets.only(top:30),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search), 
                      onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(Icons.settings_backup_restore), 
                        onPressed: (){   

                        rpvs = [];
                        ccc = [false,false,false,false,false,false,false,false,false,false,];

                        temps = [];
                        tempActive = [false,false,false,false,false,false,false,false,false];

                        sorts = [];   
                        RPV = [false,false,false,false,false,false,false,false,false,false,false,false];
                        
                        setState(() {});
                        })
                  ] ,
                  ),
                Row(
                  children:<Widget>[
                    Container(
                      margin: EdgeInsets.only(left:5,top:5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: (){
                              if(!ccc[index]) {
                                sorts.add(sort[index]);
                                changeTableDeck();
                                setState(() {
                                  ccc[index] = !ccc[index];
                                  });
                                }
                              else  if(ccc[index]){
                                sorts.remove(sort[index]);
                                changeTableDeck();
                                setState(() {
                                  ccc[index] = !ccc[index];
                                  });
                                }
                              }, 
                            child: Tooltip(
                              message: numbersToolTips[index],
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                height: MediaQuery.of(context).size.height*0.9*0.1,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                color: col = !ccc[index] ? null : (-1 <= index) & (index < 4) ? Color.fromRGBO(110, 207, 247, 1.0) : (3 < index) & (index < 6) ?                                        Color.fromRGBO(255, 243, 0, 1.0) : Color.fromRGBO(241, 114, 173, 1.0),
                                child: Center(
                                  child:Text("${index + 1}")
                                  )
                                )
                              )
                            );
                          }), 
                        ),
                      ),
                      Container(
                        child: Column(children:<Widget>[Row(
                    children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(2),
                    child: GestureDetector(
                      onTap: (){
                        if(tempActive[7]){
                          temps.remove(8);
                          tempActive[7] = !tempActive[7];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[7]){
                          temps.add(8);
                          tempActive[7] = !tempActive[7];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child:Tooltip(
                      message: "Ключевые партнёры",
                      child: !temps.contains(8) ? Image.asset("images/mini/1.png") : 
                      Image.asset("images/mini/1active.png"),
                      ),
                    ),

                    ),
                    Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[6]){
                          temps.remove(7);
                          tempActive[6] = !tempActive[6];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[6]){
                          temps.add(7);
                          tempActive[6] = !tempActive[6];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child:Tooltip(
                          message: "Ключевые виды деятельности",
                          child: temps.contains(7) ? Image.asset("images/mini/sqractive.png") : Image.asset("images/mini/sqr.png"),)
                    ),
                                          ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[5]){
                          temps.remove(6);
                          tempActive[5] = !tempActive[5];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[5]){
                          temps.add(6);
                          tempActive[5] = !tempActive[5];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(
                        message: "Ключевые ресурсы",
                        child: temps.contains(6) ? Image.asset("images/mini/sqractive.png") : 
                        Image.asset("images/mini/sqr.png"),),
                      ),
                      ),
                    ],),
                    Container(margin: EdgeInsets.all(2),
                    child: GestureDetector(
                      onTap: (){
                        if(tempActive[1]){
                          temps.remove(2);
                          tempActive[1] = !tempActive[1];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[1]){
                          temps.add(2);
                          tempActive[1] = !tempActive[1];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(message: "Ценностные предложения",
                        child:!temps.contains(2) ? Image.asset("images/mini/1.png") : Image.asset("images/mini/1active.png"),)

                      ),
                    ),
                    Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[3]){
                          temps.remove(4);
                          tempActive[3] = !tempActive[3];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[3]){
                          temps.add(4);
                          tempActive[3] = !tempActive[3];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(
                        message: "Ключевые ресурсы",
                        child: temps.contains(4) ? Image.asset("images/mini/sqractive.png") : 
                        Image.asset("images/mini/sqr.png"),),
                      ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[2]){
                          temps.remove(3);
                          tempActive[2] = !tempActive[2];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[2]){
                          temps.add(3);
                          tempActive[2] = !tempActive[2];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(
                        message: "Ключевые ресурсы",
                        child: temps.contains(3) ? Image.asset("images/mini/sqractive.png") : 
                        Image.asset("images/mini/sqr.png"),),
                      ),
                      ),
                    ],),
                    Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[0]){
                          temps.remove(1);
                          tempActive[0] = !tempActive[0];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[0]){
                          temps.add(1);
                          tempActive[0] = !tempActive[0];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(
                        message: "Ключевые ресурсы",
                        child: temps.contains(1) ? Image.asset("images/mini/1active.png") : 
                        Image.asset("images/mini/1.png"),),
                      ),
                      ),
                  ],
                  ),
                         
                    Row(children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[8]){
                          temps.remove(9);
                          tempActive[8] = !tempActive[8];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[8]){
                          temps.add(9);
                          tempActive[8] = !tempActive[8];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(message: "Структура издержек",
                      child:!temps.contains(9) ? Image.asset("images/mini/-.png") : Image.asset("images/mini/-Active.png"),)

                      ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: GestureDetector(
                      onTap: (){
                        if(tempActive[4]){
                          temps.remove(5);
                          tempActive[4] = !tempActive[4];
                          changeTableDeck();
                          setState(() {});
                        }
                        else if(!tempActive[4]){
                          temps.add(5);
                          tempActive[4] = !tempActive[4];
                          changeTableDeck();
                          setState(() {});
                        }
                      },
                      child: Tooltip(message: "Потоки доходов",
                      child:!temps.contains(5) ? Image.asset("images/mini/-.png") : Image.asset("images/mini/-Active.png"),)

                      ),
                     ) ],),] 
                         
                         ),
                         ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.9,
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(12, (index){
                          return GestureDetector(
                            onTap: (){
                              if(!RPV[index]) {
                                rpvs.add(rpv[index]);
                                changeTableDeck();
                                setState(() {
                                  RPV[index] = !RPV[index];
                                  });
                                }
                              else if(RPV[index]){
                                rpvs.remove(rpv[index]);
                                changeTableDeck();
                                setState(() {
                                  RPV[index] = !RPV[index];
                                  });
                                }
                              }, 
                            child: Tooltip(
                              message: lettersToolTips[index],
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.1,
                                height: MediaQuery.of(context).size.height*0.9/12,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                color: color_rpv = !RPV[index] ? null : (-1 <= index) & (index < 4) ? Colors.lime : (3 <= index) & (index < 8) ? Colors.pink[200] : Colors.teal[400],
                                child: Center(
                                  child:Text("${rpv[index]}")
                                  )
                                ),
                              )
                            );
                          }), 
                        ),
                    ),
                    ]
                  ),
                ]
              ),
            ),
          ),
        ),
      body: GridView.extent(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
        mainAxisSpacing: MediaQuery.of(context).size.height*0.01,
        childAspectRatio: 756 / 1150,
        crossAxisSpacing: MediaQuery.of(context).size.width*0.04,
        maxCrossAxisExtent: 189,
        children:List.generate(a.length, (index) {
   return ClipRRect(
     borderRadius: BorderRadius.circular(15.0),
     child:Hero(
            tag: index, 
            child: GestureDetector(
              child:Image.asset(a[index][image]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  fullscreenDialog: false,
                  settings: RouteSettings(

                  ),
                  builder: (context) =>  CardPage(a[index],a[index]["cardnumber"])
                  )
                  );
                }
              )
           )
   );
 
        })
        )
      );
    }
  }
class CardPages extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Map items;
    return PageView(
      children: List.generate(
        64, 
        (index){return Hero(
          tag: index,
          child: CardPage(items,index)
        )
         ;
          }
        ),
      );
    }
  }
class CardPage extends StatelessWidget{
  CardPage( this.items,this.index);
  final Map items;
  final int index;
  List examples ;
    Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/examples.json');
}
  Future<File> writeCounter(List examples) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(examples));
  }
  Future readCounter() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    List t =  jsonDecode(contents);
    for (var item in t) {
      if (items["cardnumber"] == item[2])
      examples = item;
    }
      examples = [];
  }
  Future<void> alertDialogAddExample(context){
    readCounter();
    String name;
    String desc;
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
    title: Text("Добавить свай проимер компании"),
    content: Form(
      child: Column(
        children: <Widget>[
          Text("Название компании"),
          TextFormField(
            initialValue: examples[0],
            onChanged: (value){
            name = value;
          },
          ),
          Text("Описание работы"),
          TextFormField(
            initialValue: examples[1],
            onChanged: (value){
              desc = value;
            },
          )
        ]
      )
    ),
    actions: <Widget>[
      FlatButton(
        onPressed: (){
          examples = [name,desc,items["cardnumber"]];
          writeCounter(examples);
          Navigator.pop(context);
        }, 
        child: Text("Save")),
        FlatButton(
        onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("Cancel"))
    ],
  );
      }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          alertDialogAddExample(context);
        },
        tooltip: "Add my examples",
        
        ),
      backgroundColor: Colors.grey,
      //appBar: AppBar(),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(items,index,examples),
      ),
      );
    }
  }
class Card extends StatefulWidget {
  Card(this.items,this.index,this.examples,{Key key}) : super(key: key);
  final Map items;
  List examples;
  final int index;

  CardState createState() => CardState(items,index);
}
class CardState extends State<Card> with TickerProviderStateMixin {
  CardState(this.items,this.index);
  AnimationController controller;
  final int index;
  AnimationController controller1;
  Animation sec;
  Animation qwer;
  Animation animation;
  bool front = true;
  bool anim_active = false;
  int stack = 0;
  Map items;
  List examples;
  String text ;

  List decs = [];
  List example;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> writeCounter(List examples) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(examples));
  }
  Future readExamples() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    List t =  jsonDecode(contents);
    for (var item in t) {
      if (items["cardnumber"] == item[2])
      examples = item;
    }
      examples = [];
  }
  Future<File> get _localFileexa async {
  final path = await _localPath;
  return File('$path/examples.json');
}
  Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/Decks.json');
}
  Future<File> writeCustomDecks(List decs) async {
  final file = await _localFile;
  return file.writeAsString(jsonEncode(decs));
  }
  Future readCustomDecks() async {
    final file = await _localFile;
    String contents = await file.readAsString();
    return jsonDecode(contents);
  }
  Future<void> addToCustomDeck(){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Where?"),
          children: List.generate(
            decs.length+1, (index) {
              if (index == 0){
                print("herer");
                return SimpleDialogOption(
                  child: Text("New"),
                  onPressed:(){
                    decs.add({
                      "name" : "New Deck",
                      "description" : "",
                      "heading" : items["cardnumber"],
                      "cards" : [items["cardnumber"]]
                    });
                    writeCustomDecks(decs);
                    Navigator.pop(context, decs);
                  },
                );
              }
              else{
                print("her234234er");
                return SimpleDialogOption(
                  onPressed: (){
                  if(decs[index-1]["cards"].contains(items["cardnumber"])){
                    decs[index-1]["cards"].remove(items["cardnumber"]);
                  }
                  else {
                    decs[index-1]["cards"].add(items["cardnumber"]);
                  }
                  writeCustomDecks(decs);
                  Navigator.pop(context, decs);
                }, 
                child: Text(decs[index-1]["name"]),
              );}
            }
          )
        );
      }
    );
  }
  void flip() async {
    if(!anim_active)
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
    readCustomDecks().then((value) {
      setState(() {
        decs = value;
      }
    );
  });
    super.initState();
    for (var item in items["keys"]) {
        keys = keys + item + "\n";
      }
    text = "StrategyCard.ru | Карты Бизнес-моделей 2018\n" + items["title"] + "\n" + items["short description"] + "\n" + items["ful description"] + "\n" + keys  + "\n" +  items["case"];
    controller1 =
      AnimationController(vsync: this, duration: const Duration(milliseconds : 350))
      ..addListener(() {
        setState(() {});
        });
    controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds : 350))
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
  String keys = '';
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
                      child: front ? TextSide(items, index) : 
                        Image.asset(items["backtimage"]),
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
} // CardState
class TextSide extends StatelessWidget{
  final Map items;
  TextSide(this.items,this.index);
  String text;
  final int index;
  String keys = "";

  getText(){
    keys = "";
    for (var item in items["keys"]) {
      keys = keys + item + "\n";
    }
    text = items["title"] + "\n" + items["short description"] + "\n" + items["ful description"] + "\n" + keys  + "\n" +  items["case"];
  }

  int counter = 0;

  List numbersToolTips =["Бизнес-модель", "Сеть", "Структура", "Процесс", "Совершенствование продукта", "Продуктовая система", "Сервис", "Канал" , "Бренд", "Участие клиента"];
  List lettersToolTips = ["Ресурсы -  Разнообразие (увеличение + / сокращение -)","Ресурсы - Границы (установление + / стирание -)","Ресурсы - Скорость (увеличение + / снижение -)","Ресурсы - Гибкость (повышение + / сокращение -)", "Процессы — Разнообразие (увеличение + / сокращение -)", "Процессы — Границы (установление + / стирание -)", "Процессы — Скорость (увеличение + / снижение -)", "Процессы — Гибкость (повышение + / сокращение -)","Ценности — Разнообразие (увеличение + / сокращение -)","Ценности — Границы (установление + / стирание -)","Ценности — Скорость (увеличение + / снижение -)","Ценности — Гибкость (повышение + / сокращение -)"];

  Widget build(BuildContext context) {
    final List rpv = ["R1","R2","R3","R4","P1","P2","P3","P4","V1","V2","V3","V4"];
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(-0, 0, 0, 0),
        color: Colors.white,
        child:Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(10, (index) {
                if(items["depen"].contains(index+1)){
                  return Tooltip(
                    message: numbersToolTips[index],
                    child: Container(
                    width: height * 0.6 * 756 / 1150 * 0.1,
                    height: height * 0.1 * 0.6,
                    color: (-1 <= index) & (index < 4) ? Color.fromRGBO(110, 207, 247, 1.0) : 
                    (3 < index) & (index < 6) ? Color.fromRGBO(255, 243, 0, 1.0) : 
                    Color.fromRGBO(241, 114, 173, 1.0),
                    child: Center(
                      child: Text("${index+1}"),),
                  ));
              }
            else{
              return Container(
                width: height * 0.6 * 756 / 1150 * 0.1,
                height: height * 0.1 * 0.6,
                );}})),
            Column(children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("StrategyCard.ru | Карты Бизнес-моделей 2018 \t № ${index+1}",
                  style: TextStyle(
             color: Color.fromRGBO(150, 150, 150, 1.0)
             ),
                    textScaleFactor: 0.7,
                    ),
                
                ),
              
          SizedBox(height: 12,), 
          Container(
            width: height*756*0.6/1150*0.8,
            child: Text(items["title"],
         textScaleFactor: 1.2,
           textAlign: TextAlign.start,
           style: TextStyle(
             fontWeight: FontWeight.bold,
             ),
         textDirection: TextDirection.ltr,
             ),
          ),
         
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: height*756*0.6/1150*0.5,
                height: height*0.6*0.1,
                child: Text(
                items["short description"],
                textScaleFactor: 0.7,
                style: TextStyle(
             color: Color.fromRGBO(175, 175, 175, 1.0)
             ),
              ),),
              Container(
                width: height*756*0.6/1150*0.3,
                height: height*0.6*0.1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child:ClipRRect(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(2),
                    child: Tooltip(
                      message: "Ключевые партнёры",
                      child: !items["templates"].contains(8) ? Image.asset("images/mini/1.png") : Image.asset("images/mini/1active.png"))
                    ),
                    Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Tooltip(
                          message: "Ключевые виды деятельности",
                          child: items["templates"].contains(7) ? Image.asset("images/mini/sqractive.png") : Image.asset("images/mini/sqr.png"),)
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Tooltip(message: "Ключевые ресурсы",
                        child:items["templates"].contains(6) ? Image.asset("images/mini/sqractive.png") : Image.asset("images/mini/sqr.png"),)
                      ),
                    ],),
                    Container(margin: EdgeInsets.all(2),
                    child: Tooltip(message: "Ценностные предложения",
                    child:!items["templates"].contains(2) ? Image.asset("images/mini/1.png") : Image.asset("images/mini/1active.png"),)
                    ),
                    Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Tooltip(message: "Взаимоотношения с клиентом",
                        child:items["templates"].contains(4) ? Image.asset("images/mini/sqractive.png") : Image.asset("images/mini/sqr.png"),)
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        child: Tooltip(message: "Каналы сбыта",
                        child:items["templates"].contains(3) ? Image.asset("images/mini/sqractive.png") : Image.asset("images/mini/sqr.png"),)
                      ),
                    ],),
                    Container(margin: EdgeInsets.all(2),
                    child: Tooltip(message: "Потребительские сегменты",
                    child:!items["templates"].contains(1) ? Image.asset("images/mini/1.png") : Image.asset("images/mini/1active.png"))
                    ),
                  ],),
                  Row(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(2),
                      child: Tooltip(message: "Структура издержек",
                      child:!items["templates"].contains(9) ? Image.asset("images/mini/-.png") : Image.asset("images/mini/-Active.png"),)
                    ),
                    Container(
                      margin: EdgeInsets.all(2),
                      child: Tooltip(message: "Потоки доходов",
                      child:!items["templates"].contains(5) ? Image.asset("images/mini/-.png") : Image.asset("images/mini/-Active.png"),)
                    ),
                  ],)
                ],),),
                 ),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: height*0.6*0.02),
            height: height*0.6*0.15,
            width: height*756*0.6/1150*0.8,
            child: Text(items["ful description"],
            textAlign: TextAlign.justify,
            textWidthBasis: TextWidthBasis.longestLine,
          textScaleFactor: 0.8,
            softWrap:true,),),
          SizedBox(),
          Container(
            width: height*756*0.6/1150*0.8,
            color: Color.fromRGBO(210, 210, 210, 1.0),
            child: Text("Ключи: ",
                textAlign: TextAlign.start,
                 ),
            ),
            Container(
            width: height*756*0.6/1150*0.8,
            child: Column(
              children: List.generate(items["keys"].length, (index)  {
                return Container(
                  height: items["keys"][index].length < 40 ? height*0.6*0.025 : height*0.6*0.05,
                  width: height*756*0.6/1150*0.8,
                  child:Text(items["keys"][index],
                  textScaleFactor: 0.79,
                  textAlign: TextAlign.start,
                ),
                );
              }),
            ),
            ),
            Container(
              color: Color.fromRGBO(210, 210, 210, 1.0),
              width: height*756*0.6/1150*0.8,
              child:Text("Примеры компаний",
              style: TextStyle(
                fontWeight: FontWeight.bold,),
              textAlign: TextAlign.start,
            ),),Container(
              width: height*756*0.6/1150*0.8,
              height: 15,
              child: Text(items["companies"],
              textAlign: TextAlign.justify,
                  textScaleFactor: 0.8,),
            ),
            Container(
              width: height*756*0.6/1150*0.8,
              height: height*0.6*0.3,
              child: Text(items["case"],
              textAlign: TextAlign.justify,
                  textScaleFactor: 0.8,),
            ),
          ]
        ),
          Column(
          crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(12, (index) {
                String f = rpv[index];
                bool plus = items["sort"].contains(f + '+') ^ items["sort"].contains(f + '+' + f + "-");
                bool minus = items["sort"].contains(f + '-');
                bool r = index < 4;
                bool p = (3 < index) & (index < 8);
                if(plus ^ minus){
                  return Tooltip(
                    message: lettersToolTips[index],
                  child:Container(
                    alignment: Alignment.centerRight,
                    width: height * 0.6 * 756 / 1150 * 0.1,
                    height: height * 1 / 12 * 0.6,
                    color: 
                      r ? plus ? Color.fromRGBO(173, 213, 129, 1.0): Color.fromRGBO(137, 171, 84, 1.0) : 
                      p ? plus ? Color.fromRGBO(247, 159, 122, 1.0) : Color.fromRGBO(217, 126, 137, 1.0) :
                      plus ? Color.fromRGBO(114, 199, 165, 1.0) : Color.fromRGBO(72, 159, 124, 1.0),
                    child: Center(
                      child: Text("${items["sort"][counter+1]}"),),
                  ),
                  );
              }
            else{
              return Container(
                width: height * 0.6 * 756 / 1150 * 0.1,
                height: height * 1 / 12 * 0.6,
              );
            }
            }
          ),
          ),
          ]
        ),
      ),
    );
  }
}
class MyDeck extends StatefulWidget{
  MyDeck(this.items,this.deck);
  final List items;
  final Map deck;
  State<StatefulWidget> createState() => MyDeckState(items, deck);
}
class MyDeckState extends State<MyDeck>{
  MyDeckState(this.items,this.deck);
  final List items;
  final Map deck;
  var r;
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
            },)
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
        child: Text("Save")),
    ],
  );
      }
      );
  }
  Widget build(context) {
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
          height: MediaQuery.of(context).size.height * 0.4,
         child:AspectRatio(
           aspectRatio: 756/1150,
           child: Image.asset(items[deck["cards"][0]]["frontimage"]),)
        ),
        Text("Other Cards"),
        Container(
          height: 300,
          child: GridView.extent(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
        mainAxisSpacing: MediaQuery.of(context).size.height*0.01,
        childAspectRatio: 756 / 1150,
        crossAxisSpacing: MediaQuery.of(context).size.width*0.04,
        maxCrossAxisExtent: 189,
        children:List.generate(deck["cards"].length-1, (index) {
   return ClipRRect(
     borderRadius: BorderRadius.circular(15.0),
     child:Hero(
            tag: index, 
            child: GestureDetector(
              child:Image.asset(items[deck["cards"][index+1]]["frontimage"]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  CardPage(items[deck["cards"][index+1]],items[deck["cards"][index+1]]["cardnumber"])
                  )
                  );
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
