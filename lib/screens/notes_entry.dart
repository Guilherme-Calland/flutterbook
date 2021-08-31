import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/model/note.dart';
import 'package:flutterbook/widgets/color_sticker.dart';
import 'package:flutterbook/widgets/flutter_book_button.dart';

import '../utils.dart';

class NotesEntry extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleEditingController = TextEditingController();
  final _contentEditingController = TextEditingController();

  @override
  Widget build(BuildContext inContext) {
    
    if(notANewNote()){
      setEntriesToUpdatingNote();
    }
    
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.title),
              title: TextFormField(
                controller: _titleEditingController,
                decoration: InputDecoration(hintText: 'title'),
                onChanged: (String? inValue){
                  notesStore.entityBeingEdited.title = inValue;
                },
                validator: checkIfInputIsValid,
              ),
            ),
            ListTile(
              leading: Icon(Icons.content_paste),
              title: TextFormField(
                controller: _contentEditingController,
                onChanged: (String? inValue){
                  notesStore.entityBeingEdited.content = inValue;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: InputDecoration(hintText: 'content'),
                validator: checkIfInputIsValid,
              ),
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Row(
                children: [
                  ColorSticker(inColor: Colors.red, inColorName: 'red',),
                  Spacer(),
                  ColorSticker(inColorName: 'green', inColor: Colors.green),
                  Spacer(),
                  ColorSticker(inColorName: 'blue', inColor: Colors.blue,),
                  Spacer(),
                  ColorSticker(inColorName: 'yellow', inColor: Colors.yellow,),
                  Spacer(),
                  ColorSticker(inColorName: 'grey', inColor: Colors.grey,),
                  Spacer(),
                  ColorSticker(inColorName: 'purple', inColor: Colors.purple,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          children: [
            FlutterBookButton(
              text: 'cancel',
              color: Colors.pink,
              onTap: () {
                hideKeyboard(inContext);
                notesStore.loadData(notesDB);
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
            )
          ],
        ),
      ),
    );
  }

  void setEntriesToUpdatingNote() {
    _titleEditingController.text = notesStore.entityBeingEdited.title;
    _contentEditingController.text = notesStore.entityBeingEdited.content;
  }

  bool notANewNote() => notesStore.entityBeingEdited != null;

  void _save(BuildContext inContext) async {
    if( !_formKey.currentState!.validate()){
      return;
    }else {
      if (notesStore.entityBeingEdited.id == null) {
        int? result = await _createNewNote();
        if (result != null) {
          if (result >= 0) {
            showSnackBar('Note Created', inContext, color: Colors.green);
          }
        }
      } else {
        int? result = await updateOldNote();
        if (result != null) {
          if (result >= 0) {
            showSnackBar('Note Saved', inContext, color: Colors.blue);
          }
        }
      }
      notesStore.loadData(notesDB);
      notesStore.setStackIndex(0);
    }
  }

  Future<int?> updateOldNote() async {
    Map<String, dynamic> data = notesStore.entityBeingEdited.noteToMap();
    int? result = await notesDB.update(data);
    if(result != null){
      if(result >= 0){
        print('$result note was updated successfully!');
      }
    }else{
      print('something went wrong updating');
    }

    return result;
  }

  Future<int?> _createNewNote() async {
    Map<String, dynamic> data = notesStore.entityBeingEdited.noteToMap();
    int? result = await notesDB.create(data);
    if(result != null){
      if(result >= 0){
        print('note of id $result was created successfully!');
      } else {
        print('note was not created');
      }
    } else {
      print('note was called on null');
    }
    return result;
  }

  String? checkIfInputIsValid(String? inValue) {
    if (inValue == null)
      print('title was given a null value');
    else if (inValue!.length == 0) {
      return 'please enter a title';
    }
    return null;
  }
}


