import 'package:flutter/material.dart';
import 'package:flutterbook/screens/appointments_screen.dart';
import 'package:flutterbook/screens/contacts_screen.dart';
import 'package:flutterbook/screens/notes_screen.dart';
import 'package:flutterbook/screens/tasks_screen.dart';

void main() async {
  runApp(FlutterBook());
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