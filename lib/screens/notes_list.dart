import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/model/note.dart';

import '../utils.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(_) {
    return Observer(
      builder: (_){
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: (){
              notesStore.entityBeingEdited = Note();
              notesStore.setColor(null);
              notesStore.setStackIndex(1);
            },
          ),
          body: ListView.builder(
            itemCount: notesStore.entityList.length,
            itemBuilder: (_, int inIndex){
              Note note = notesStore.entityList[inIndex];
              Color color = Colors.white;
              switch(note.color)
              {
                case 'red' : color = Colors.red; break;
                case 'green' : color = Colors.green; break;
                case 'blue' : color = Colors.blue; break;
                case 'yellow' : color = Colors.yellow; break;
                case 'grey' : color = Colors.grey; break;
                case 'purple' : color = Colors.purple; break;
              }
              return ListTile(
                title: Text(note.title!),
              );
            }
          ),
        );
      },
    );
  }
}
