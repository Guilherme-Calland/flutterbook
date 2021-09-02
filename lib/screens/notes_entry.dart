import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/model/note.dart';
import 'package:flutterbook/widgets/color_sticker.dart';
import 'package:flutterbook/widgets/flutter_book_button.dart';

import '../utils.dart';

class NotesEntry extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(_) {
    return Observer(
      builder: (BuildContext inContext) {
        checkIfCreatingOrEditing();
        return Scaffold(
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.title),
                  title: TextFormField(
                    decoration: InputDecoration(hintText: 'title'),
                    controller: _titleController,
                    validator: (String? inValue) {
                      return validateText(
                          inValue, 'please enter a valid title');
                    },
                    onChanged: (String inValue) {
                      notesStore.entityBeingEdited.title = inValue;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.content_paste),
                  title: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: InputDecoration(hintText: 'content'),
                    controller: _contentController,
                    validator: (String? inValue) {
                      return validateText(
                          inValue, 'please enter valid content');
                    },
                    onChanged: (String inValue){
                      notesStore.entityBeingEdited.content = inValue;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.color_lens),
                  title: Row(
                    children: [
                      ColorSticker(inColor: Colors.red, inColorName: 'red'),
                      Spacer(),
                      ColorSticker(inColor: Colors.green, inColorName: 'green'),
                      Spacer(),
                      ColorSticker(inColor: Colors.blue, inColorName: 'blue'),
                      Spacer(),
                      ColorSticker(inColor: Colors.yellow, inColorName: 'yellow'),
                      Spacer(),
                      ColorSticker(inColor: Colors.grey, inColorName: 'grey'),
                      Spacer(),
                      ColorSticker(inColor: Colors.purple, inColorName: 'purple',)
                    ],
                  )
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Row(
              children: [
                FlutterBookButton(
                  text: 'cancel',
                  color: Colors.blue,
                  onTap: () {
                    hideKeyboard(inContext);
                    notesStore.loadData('notes', notesDB);
                    notesStore.setStackIndex(0);
                  },
                ),
                Spacer(),
                FlutterBookButton(
                  text: 'save',
                  color: Colors.green,
                  onTap: () {
                    _save(inContext);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void checkIfCreatingOrEditing() {
    if (notesStore.entityBeingEdited != null) {
      if (notesStore.entityBeingEdited.id != null) {
        _titleController.text = notesStore.entityBeingEdited.title;
        _contentController.text = notesStore.entityBeingEdited.content;
      }
    }
  }

  void _save(BuildContext inContext) async {
    if (_formKey.currentState != null) {
      if (!_formKey.currentState!.validate()) {
        return;
      }
    }

    Note inNote = notesStore.entityBeingEdited;
    Map<String, dynamic> data = inNote.noteToMap();

    if (isANewNote()) {
      int? result = await notesDB.create(data);
      print('note of id $result was saved in the database!');
    } else {
      int? result = await notesDB.update(data);
      print('$result not was updated in the database!');
    }

    notesStore.loadData('notes', notesDB);
    notesStore.setStackIndex(0);
    showSnackBar(inContext, inText: 'Note Saved', inColor: Colors.green);
  }

  bool isANewNote() => notesStore.entityBeingEdited.id == null;
}
