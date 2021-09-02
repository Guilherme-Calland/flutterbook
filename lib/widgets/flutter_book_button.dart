import 'package:flutter/material.dart';

class FlutterBookButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onTap;

  FlutterBookButton(
      {required this.text, required this.color, required this.onTap});

  @override
  Widget build(_) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24,),
        child: Text(text, style: TextStyle(color: Colors.white,),),
      ),
    );
  }
}