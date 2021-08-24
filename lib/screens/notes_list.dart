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
            itemBuilder: (BuildContext inContext, int inIndex) {
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
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => _deleteNote(inContext, note),
                    )
                  ],
                  actionPane: Container(),
                  child: Card(
                    elevation: 8,
                    color: color,
                    child: ListTile(
                      title: Text('${note.title}'),
                      subtitle: Text('${note.content}'),
                      onTap: () async {
                        if (note.id != null) {
                          notesStore.entityBeingEdited =
                              await notesDB.get(note.id!);
                          notesStore
                              .setColor(notesStore.entityBeingEdited.color);
                          notesStore.setStackIndex(1);
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

  Future<void> _deleteNote(BuildContext inContext, Note inNote) {
    return showDialog(
      context: inContext,
      barrierDismissible: false,
      builder: (BuildContext inAlertContext) {
        return AlertDialog(
          title: Text('delete note'),
          content: Text('are you sure you want to delete ${inNote.title}?'),
          actions: [
            FlutterBookButton(
              inColor: Colors.blue,
              inText: 'cancel',
              onTap: () {
                popAlertDialog(inAlertContext);
              },
            ),
            FlutterBookButton(
              inColor: Colors.red,
              inText: 'delete',
              onTap: () async {
                await deleteNote(inNote, inAlertContext, inContext);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteNote(
      Note inNote, BuildContext inAlertContext, BuildContext inContext) async {
    if (inNote.id != null) {
      int? result = await notesDB.delete(inNote.id!);
      if (result != null) print('$result note was deleted successfully');
      popAlertDialog(inAlertContext);
      String text = 'note deleted';
      showSnackBar(text, inContext);
      notesStore.loadData(notesDB);
    } else {
      print('note id was called on null in trying to delete!');
    }
  }
}

class FlutterBookButton extends StatelessWidget {
  FlutterBookButton({
    required this.inColor,
    required this.inText,
    required this.onTap,
  });

  final Color inColor;
  final String inText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        color: inColor,
        child: Text(
          inText,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}
