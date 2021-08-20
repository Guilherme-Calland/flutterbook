import 'package:flutter/material.dart';
import 'package:flutterbook/database/notes_db_worker.dart';
import 'package:flutterbook/main.dart';
import 'package:flutterbook/stores/notes_store.dart';

import '../utils.dart';

class NotesScreen extends StatelessWidget {

  NotesScreen(){
    notesStore.loadData(notesDB);
  }

  @override
  Widget build(_){
    return Center(
      child: Text('NotesScreen'),
    );
  }
}
