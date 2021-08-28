import 'package:flutter/material.dart';

class Note {
  int? id;
  String? title;
  String? content;
  String? color;

  Note({this.title, this.id, this.color});

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

  Map<String, dynamic> noteToMap(Note inNote){
    Map<String, dynamic> outMap = {
      'title' : inNote.title,
      'content' : inNote.content,
      'color' : inNote.color
    };

    if(id!=null){
      outMap['id'] = inNote.id;
    }

    return outMap;
  }


}