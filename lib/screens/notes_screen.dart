import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/database/notes_db_worker.dart';
import 'package:flutterbook/main.dart';
import 'package:flutterbook/stores/notes_store.dart';

import '../utils.dart';
import 'notes_entry.dart';
import 'notes_list.dart';

class NotesScreen extends StatelessWidget {

  NotesScreen(){
    notesStore.loadData(notesDB);
  }

  @override
  Widget build(_){
    return Observer(
      builder: (_){
        return IndexedStack(
          index: notesStore.stackIndex,
          children: [
            NotesList(),
            NotesEntry()
          ],
        );
      },
    );
  }
}
