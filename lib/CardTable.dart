import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
import 'CardPage.dart';
import 'DecksDrawer.dart';
import 'Sqr.dart';
import 'AddCard.dart';

class CardTable extends StatefulWidget{
  CardTable(this.items, this.decs);
  final List items;
  final List decs;
  @override
  State<StatefulWidget> createState() => CardTableState(items,decs);
}
class CardTableState extends State<CardTable> {
  CardTableState(this.items, this.decs);
  List decs = [];
  List items;
  String path;
  List<Map> customCards = [];
  File customCardsFile;
  List a = [];

  List<bool>  rpvs = [true,true,true,true,true,true,true,true,true,true,true,true]; // 12
  List<bool> sorts = [true,true,true,true,true,true,true,true,true,true];           // 10
  List<bool> temps = [true,true,true,true,true,true,true,true,true];                // 9

  List<String> numbersToolTips =["Бизнес-модель", "Сеть", "Структура", "Процесс", "Совершенствование продукта", "Продуктовая система", "Сервис", "Канал" , "Бренд", "Участие клиента"];
  List<String> lettersToolTips = ["Ресурсы -  Разнообразие (увеличение + / сокращение -)","Ресурсы - Границы (установление + / стирание -)","Ресурсы - Скорость (увеличение + / снижение -)","Ресурсы - Гибкость (повышение + / сокращение -)", "Процессы — Разнообразие (увеличение + / сокращение -)", "Процессы — Границы (установление + / стирание -)", "Процессы — Скорость (увеличение + / снижение -)", "Процессы — Гибкость (повышение + / сокращение -)","Ценности — Разнообразие (увеличение + / сокращение -)","Ценности — Границы (установление + / стирание -)","Ценности — Скорость (увеличение + / снижение -)","Ценности — Гибкость (повышение + / сокращение -)"];

  File decksFile;
  Size size;
  getDecks(){
    try {
      decs =  jsonDecode(decksFile.readAsStringSync());
    } catch (e) {}
    decs = [];
    setState(() {});
  }
  getData() async {
    getApplicationDocumentsDirectory().then((value) {
      path = value.path;
      decksFile = File('$path/Decks.json');
      customCardsFile = File("$path/customerDecks.json");
      try {
        customCards = jsonDecode(customCardsFile.readAsStringSync());
      } catch (e) {
        customCardsFile.writeAsStringSync("[]");
      }
      getDecks();
      setState(() {});
    });
  }
  initState() {
    super.initState();
    getData();
    //decksFile.writeAsString(jsonEncode(decs));
    for (var item in items) {
      a.add(item);
      }
    setState(() {});
  }
  
  changeTableDeck(){
    a = [];
    List<Map> intersection = [];
    List<Map> association = [];
    List<int> nums = [];
    List<int> nums1 = [];
    List<String> nums2 = [];

    bool inter = true;
    bool ok = false;
    for (var i = 0; i < 10; i++) {
      if (sorts[i]) {
        nums.add(i+1);
      }
    }

    for (var i = 0; i < 9; i++) {
      if (temps[i]) {
        nums1.add(i+1);
      }
    }

    for (var i = 0; i < 12; i++) {
      if (rpvs[i]) {
        String eee = i < 4 ? 'R' : i < 6 ? "P" : "V";
        eee += ((i % 4)+1).toString();
        nums2.add(eee);
      }
    }

    for (var item in items) {
      ok = false;
      inter = true;
      for (var _sort in nums) {
        if(!item["depen"].contains(_sort)){
          inter = false;
        }
        else{
          ok = true;
        }
      }
      for (var e in nums2) {
        if(!item["sort"].contains(e + '+') ^ 
          !item["sort"].contains(e + '-') ^ 
          !item["sort"].contains(e + '+' + e + "-")){
          inter = false;
        }
        else{
          ok = true;
        }
      }
      for (var _temp in nums1) {
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
    setState(() {});
  }
  Widget build(context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => alertDialogAddCard(context, items.length + customCards.length, customCardsFile),
        tooltip: "Add my examples",
      ),
      backgroundColor: Colors.brown,
      endDrawer: DecksDrawer(decs),
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
                        rpvs = [false,false,false,false,false,false,false,false,false,false,false,false]; // 12
                        sorts = [false,false,false,false,false,false,false,false,false,false];           // 10
                        temps = [false,false,false,false,false,false,false,false,false];                // 9
                        setState(() {});
                      }
                    )
                  ] ,
                ),
                Row(
                  children:<Widget>[
                    Container(
                      margin: EdgeInsets.only(left:5,top:5,right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: (){
                              sorts[index] = !sorts[index];
                              changeTableDeck();
                              setState(() {});
                            }, 
                            child: Tooltip(
                              message: numbersToolTips[index],
                              child: Container(
                                width: size.width*0.1,
                                height: size.height*0.9*0.1,
                                color: !sorts[index] ? null : index < 4 ? Color.fromRGBO(110, 207, 247, 1.0) : index < 6 ? Color.fromRGBO(255, 243, 0, 1.0) : Color.fromRGBO(241, 114, 173, 1.0),
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          children:<Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: GestureDetector(
                                    onTap: (){
                                      temps[7] = !temps[7];
                                      changeTableDeck();
                                    },
                                    child:Tooltip(
                                      message: "Ключевые партнёры", 
                                      child: Sqr(35, 72, temps[7])
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          temps[6] = !temps[6];
                                          changeTableDeck();
                                        },
                                        child:Tooltip(
                                          message: "Ключевые виды деятельности",
                                          child: Sqr(30, 35, temps[6])
                                        )
                                      ),
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          temps[5] = !temps[5];
                                          changeTableDeck();
                                        },
                                        child: Tooltip(
                                          message: "Ключевые ресурсы",
                                          child: Sqr(30, 35, temps[5])
                                        ),
                                    ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: (){
                                      temps[1] = !temps[1];
                                      changeTableDeck();
                                    },
                                    child: Tooltip(
                                      message: "Ценностные предложения",
                                      child: Sqr(35, 72, temps[1])
                                    )
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      child: GestureDetector(
                                        onTap: (){
                                          temps[3] = !temps[3];
                                          changeTableDeck();
                                        },
                                        child: Tooltip(
                                          message: "Ключевые ресурсы",
                                          child: Sqr(30, 35, temps[3])
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      child: GestureDetector(
                                        onTap: (){
                                          temps[2] = !temps[2];
                                          changeTableDeck();
                                        },
                                        child: Tooltip(
                                          message: "Ключевые ресурсы",
                                          child: Sqr(30, 35, temps[2])
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: (){
                                      temps[0] = !temps[0];
                                      changeTableDeck();
                                    },
                                    child: Tooltip(
                                      message: "Ключевые ресурсы",
                                      child: Sqr(35, 72, temps[0])
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: GestureDetector(
                                    onTap: (){
                                      temps[8] = !temps[8];
                                      changeTableDeck();
                                      setState(() {});
                                    },
                                    child: Tooltip(
                                      message: "Структура издержек",
                                      child: Sqr(86, 24, temps[8])
                                    )
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: (){
                                      temps[4] = !temps[4];
                                      changeTableDeck();
                                      setState(() {});
                                    },
                                    child: Tooltip(
                                      message: "Потоки доходов",
                                      child: Sqr(86, 24, temps[4])
                                    )
                                  ),
                                ), 
                              ]
                            ),
                          ]
                        ),
                      )
                    ), // контейнер отвечает за БМ
                    Container(
                      height: size.height*0.9,
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(12, (i){ // i is for index
                          return GestureDetector(
                            onTap: (){
                              rpvs[i] = !rpvs[i];
                              changeTableDeck();
                            }, 
                            child: Tooltip(
                              message: lettersToolTips[i],
                              child: Container(
                                width: size.width*0.1,
                                height: size.height*0.9/12,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                color: !rpvs[i] ? null : i < 4 ? Colors.lime : i < 8 ? Colors.pink[200] : Colors.teal[400],
                                child: Center(
                                  child:Text("${(i < 4 ? "R" : i < 8 ? "P" : "V") + ((i % 4) + 1).toString()}")
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
        padding: EdgeInsets.all(size.height * 0.01),
        mainAxisSpacing: size.height * 0.01,
        childAspectRatio: 756 / 1150,
        crossAxisSpacing: size.width * 0.04,
        maxCrossAxisExtent: 189,
        children:List.generate(a.length, (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child:Hero(
              tag: index, 
              child: GestureDetector(
                child:Image.asset("images/${a[index]["cardnumber"]}-front.png"),
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) =>  CardPage(a[index],a[index]["cardnumber"])
                  )
                )
              )
            )
          );
        })
      )
    );
  }
}