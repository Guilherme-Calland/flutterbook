import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterbook/database/notes_db_worker.dart';
import 'package:flutterbook/screens/appointments_screen.dart';
import 'package:flutterbook/screens/contacts_screen.dart';
import 'package:flutterbook/screens/notes_screen.dart';
import 'package:flutterbook/screens/tasks_screen.dart';

NotesDBWorker notesDB = NotesDBWorker();

void main() async {
  runApp(FlutterBook());
  // testingCreation();
  // testingReading();
  // testUpdating();
  testDeleting();
  testReadingAll();
}

Future<void> testDeleting() async {
  int? result = await notesDB.delete(2);
  result != null ?
      print('$result item was deleted successfully!')
      :
      print('something went wrong in deleting the data');
}

Future<void> testingCreation() async {
  var data = {
    'title' : 'testTitle',
    'content' : 'testContext',
    'color' : 'testColor'
  };

  int? result = await notesDB.create(data);
  if(result != null){
    print('data of id $result was successfully saved');
  }else{
    print('result on creation returned null');
  }
}

Future<void> testingReading() async {
  var result = await notesDB.get(2);
  print(result);
}

Future<void> testReadingAll() async {
  List? result = await notesDB.read();
  if(result != null){
    result.forEach((map){
      print(map);
    });
  } else {
    print('result came in null :(');
  }
}

Future<void> testUpdating() async {
  Map<String, dynamic> newData = {
    'id' : 3,
    'title' : 'new edited title',
  };
  int? result = await notesDB.update(newData);
  if(result != null){
    print('data of id $result was updates');
  }else{
    print('data was called on null (update)');
  }
}

class FlutterBook extends StatelessWidget {
  @override
  Widget build(_) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('flutterbook'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.date_range),
                  // text: 'appointments',
                ),
                Tab(
                  icon: Icon(Icons.contacts),
                  // text: 'contacts',
                ),
                Tab(
                  icon: Icon(Icons.note),
                  // text: 'notes',
                ),
                Tab(
                  icon: Icon(Icons.assignment_turned_in),
                  // text: 'tasks',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AppointmentsScreen(), ContactsScreen(), NotesScreen(), TasksScreen()
            ],
          ),
        ),
      ),
    );
  }
}