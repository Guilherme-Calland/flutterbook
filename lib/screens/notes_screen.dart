import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../utils.dart';
import 'notes_entry.dart';
import 'notes_list.dart';

class NotesScreen extends StatelessWidget {

  NotesScreen(){
    notesStore.loadData('notes', notesDB);
  }

  @override
  Widget build(_){
    return Observer(
      builder: (_){
        return IndexedStack(
          index: notesStore.stackIndex,
          children: [
            NotesList(),
            NotesEntry(),
          ],
        );
      },
    );
  }
}
