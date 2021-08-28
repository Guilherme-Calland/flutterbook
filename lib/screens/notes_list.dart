import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterbook/model/note.dart';

import '../utils.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(_) {
    return Observer(
      builder: (_) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              notesStore.entityBeingEdited = Note();
              notesStore.setColor(null);
              notesStore.setStackIndex(1);
            },
          ),
          body: ListView.builder(
            itemCount: notesStore.entityList.length,
            itemBuilder: (_, int inIndex) {
              Note note = notesStore.entityList[inIndex];
              Color color = Colors.white;
              switch (note.color) {
                case 'red':
                  color = Colors.red;
                  break;
                case 'green':
                  color = Colors.green;
                  break;
                case 'blue':
                  color = Colors.blue;
                  break;
                case 'yellow':
                  color = Colors.yellow;
                  break;
                case 'grey':
                  color = Colors.grey;
                  break;
                case 'purple':
                  color = Colors.purple;
                  break;
              }
              return Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Slidable(
                  actionExtentRatio: .25,
                  actionPane: SlidableScrollActionPane(),
                  actions: [
                    IconSlideAction(
                      caption: 'delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        // _deleteNote(inContext, note)
                        print('to be implemented...');
                      },
                    ),
                  ],
                  child: Card(
                    elevation: 8,
                    color: color,
                    child: ListTile(
                      title: Text('${note.title}'),
                      subtitle: Text('${note.content}'),
                      onTap: () async {
                        if(note.id != null){
                          notesStore.entityBeingEdited =
                          await notesDB.get(note.id!);
                          notesStore.setColor(note.color);
                          notesStore.setStackIndex(1);
                          print('Note:\nid:${note.id}\ntitle:${note.title}');
                        } else {
                          print('note was called on null');
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
