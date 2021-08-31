import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterbook/model/note.dart';
import 'package:flutterbook/widgets/flutter_book_button.dart';

import '../utils.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext inContext) {
    return Observer(
      builder: (_) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              notesStore.entityBeingEdited = Note(title: '',content: '');
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
                    GestureDetector(
                      onTap: () => _deleteNote(inContext, note),
                      child: Container(
                        color: Colors.red,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                  child: Card(
                    elevation: 8,
                    color: color,
                    child: ListTile(
                      title: Text('${note.title}'),
                      subtitle: Text('${note.content}'),
                      onTap: () async {
                        notesStore.entityBeingEdited = note;
                        notesStore.setColor(note.color);
                        notesStore.setStackIndex(1);
                      }
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

  Future _deleteNote(BuildContext inContext, Note inNote) {
    return showDialog(
      context: inContext,
      barrierDismissible: false,
      builder: (BuildContext inAlertContext) {
        return AlertDialog(
          title: Text('delete note'),
          content: Text('are you sure you want to delete "${inNote.title}"?'),
          actions: [
            FlutterBookButton(
              text: 'cancel',
              color: Colors.blue,
              onTap: () {
                popNavigator(inAlertContext);
              },
            ),
            FlutterBookButton(
              text: 'delete',
              color: Colors.red,
              onTap: () async {
                int? result = await notesDB.delete(inNote.id!);
                if(result == 1){
                  print('$result note was deleted successfully!');
                } else {
                  print('something went wrong in note deletion');
                }
                showSnackBar('note deleted', inContext, color: Colors.red);
                notesStore.loadData(notesDB);
                popNavigator(inAlertContext);
              },
            )
          ],
        );
      },
    );
  }
}
