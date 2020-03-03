import 'package:flutter/material.dart';

class Sqr extends StatelessWidget{
  Sqr(this.width, this.height,this.enabled);
  final bool enabled;
  final double width;
  final double height;
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
      margin: EdgeInsets.only(
        right: 3,
        left: 3,
        bottom: 4,
      ),
      child: Container(
        color: enabled ? Colors.yellow : null,
        width: 17,
        height: 17,
        margin: EdgeInsets.only(
          top: height == 24 ? 3 : 5,
          left: width == 86 ? 60 : 9,
          right: 9,  
          bottom: height == 24 ? 3 : 9,
        ),
      ),
    );
  }
}