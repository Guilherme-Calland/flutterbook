import 'package:flutter/material.dart';

class Note {
  int? id;
  String? title;
  String? content;
  String? color;

  Note({this.title, this.id, this.color, this.content});

  String toString() {
    return
    '{'
    'id=$id, title=$title, content=$content, color=$color'
    '}';
  }

  Note.mapToNote(Map<String, dynamic> inMap){
    id = inMap['id'];
    title = inMap['title'];
    content = inMap['content'];
    color = inMap['color'];
  }

  Map<String, dynamic> noteToMap(){
    Map<String, dynamic> outMap = {
      'title' : this.title,
      'content' : this.content,
      'color' : this.color
    };

    if(id!=null){
      outMap['id'] = this.id;
    }

    return outMap;
  }


}