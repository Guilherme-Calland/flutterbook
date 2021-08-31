import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/model/note.dart';
import 'package:flutterbook/widgets/flutter_book_button.dart';

import '../utils.dart';

class NotesEntry extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleEditingController = TextEditingController();
  final _contentEditingController = TextEditingController();

  @override
  Widget build(BuildContext inContext) {

    _titleEditingController.text = notesStore.entityBeingEdited.title;
    _contentEditingController.text = notesStore.entityBeingEdited.content;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.title),
              title: TextFormField(
                decoration: InputDecoration(hintText: 'title'),
                controller: ,
              ),
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
              color: Colors.pink,
              onTap: () {
                hideKeyboard(inContext);
                notesStore.setStackIndex(0);
              },
            ),
            Spacer(),
            FlutterBookButton(
              text: 'save',
              color: Colors.green,
              onTap: () {
                showSnackBar('to be implemented...', inContext, color: Colors.purple);
              },
            )
          ],
        ),
      ),
    );
  }
}
