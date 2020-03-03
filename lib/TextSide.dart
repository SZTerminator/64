import 'package:flutter/material.dart';
import 'Sqr.dart';

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
                   Tooltip(
                      message: "Ключевые партнёры",
                      child: Sqr(35, 72, items["templates"].contains(8))),
                  
                    Column(children: <Widget>[
                      Tooltip(
                          message: "Ключевые виды деятельности",
                          child: Sqr(30, 35,items["templates"].contains(7)))
                     ,
                      Tooltip(message: "Ключевые ресурсы",
                        child: Sqr(30, 35, items["templates"].contains(6)))
                     
                    ],),
                    Tooltip(message: "Ценностные предложения",
                    child: Sqr(35, 72, items["templates"].contains(2)))
                   ,
                    Column(children: <Widget>[
                      Tooltip(message: "Взаимоотношения с клиентом",
                        child: Sqr(30, 35, items["templates"].contains(4)))
                    ,
                     Tooltip(message: "Каналы сбыта",
                        child: Sqr(30, 35, items["templates"].contains(3)))
                    
                    ],),
                  Tooltip(message: "Потребительские сегменты",
                    child: Sqr(35, 72, items["templates"].contains(1)))
                  
                  ],),
                  Row(children: <Widget>[
                    Tooltip(message: "Структура издержек",
                      child: Sqr(86, 24, items["templates"].contains(9)),)
                   ,
                   Tooltip(message: "Потоки доходов",
                      child: Sqr(86, 24, items["templates"].contains(5)),)
                   
                  ],)
                ],),),
                 ),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: height*0.6*0.01),
            height: height*0.6*0.15,
            width: height*756*0.6/1150*0.76,
            child: Text(
              items["ful description"],
              textAlign: TextAlign.justify),
          ),
          Container(
            width: height*756*0.6/1150*0.8,
            color: Color.fromRGBO(210, 210, 210, 1.0),
            child: Text("Ключи: "),
          ),
          Container(
            width: height*756*0.6/1150*0.8,
            child: Column(
              children: List.generate(items["keys"].length, (index)  {
                return Container(
                  height: items["keys"][index].length < 43 ? height*0.6*0.025 : height*0.6*0.05,
                  width: height*756*0.6/1150*0.8,
                  child:Text(
                    items["keys"][index],
                    textScaleFactor: 0.7,
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
