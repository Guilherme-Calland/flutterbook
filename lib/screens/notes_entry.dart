import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/screens/notes_list.dart';

import '../utils.dart';

class NotesEntry extends StatelessWidget {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(_) {
    return Observer(
      builder: (BuildContext inContext) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.title),
                  title: TextFormField(
                    decoration: InputDecoration(hintText: 'title'),
                    controller: _titleEditingController,
                    onChanged: (String inValue) {
                      notesStore.entityBeingEdited.text = inValue;
                    },
                    validator: (String? inValue) {
                      if (inValue != null) {
                        if (inValue.length == 0) {
                          return 'please enter a title';
                        }
                        return null;
                      }
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.content_paste),
                  title: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    decoration: InputDecoration(hintText: 'content'),
                    controller: _contentEditingController,
                    onChanged: (String inValue) {
                      notesStore.entityBeingEdited.content = inValue;
                    },
                    validator: (String? inValue) {
                      if (inValue == null || inValue.length == 0) {
                        return 'please enter content';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.color_lens),
                  title: Row(
                    children: [
                      ColorSquare(
                        color: Colors.red,
                        colorName: 'red',
                      ),
                      Spacer(),
                      ColorSquare(
                        color: Colors.green,
                        colorName: 'green',
                      ),
                      Spacer(),
                      ColorSquare(
                        color: Colors.blue,
                        colorName: 'blue',
                      ),
                      Spacer(),
                      ColorSquare(
                        color: Colors.yellow,
                        colorName: 'yellow',
                      ),
                      Spacer(),
                      ColorSquare(
                        color: Colors.grey,
                        colorName: 'grey',
                      ),
                      Spacer(),
                      ColorSquare(
                        color: Colors.purple,
                        colorName: 'purple',
                      ),
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
                  inColor: Colors.pink,
                  inText: 'cancel',
                  onTap: () {
                    FocusScope.of(inContext).requestFocus(FocusNode());
                    notesStore.setStackIndex(0);
                  },
                ),
                Spacer(),
                FlutterBookButton(
                  inColor: Colors.green,
                  inText: 'save',
                  onTap: () {
                    print('to be implemented... (save)');
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorSquare extends StatelessWidget {
  final Color color;
  final String colorName;

  ColorSquare({required this.color, required this.colorName});

  @override
  Widget build(BuildContext inContext) {
    return Observer(
      builder: (_){
        return GestureDetector(
          child: Container(
            decoration: ShapeDecoration(
              shape: Border.all(
                width: 18,
                color: color,
              ) +
                  Border.all(
                    width: 6,
                    color: notesStore.color == colorName
                        ? color
                        : Theme.of(inContext).canvasColor,
                  ),
            ),
          ),
          onTap: () {
            notesStore.entityBeingEdited.color = colorName;
            notesStore.setColor(colorName);
          },
        );
      },
    );
  }
}
