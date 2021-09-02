import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterbook/model/task.dart';
import 'package:intl/intl.dart';

import '../utils.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(_) {
    return Observer(
      builder: (_) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              //tasksStore.entityBeingEdited = Task();
              //tasksStore.setStackIndex(1);
            },
          ),
          body: ListView.builder(
            itemCount: tasksStore.entityList.length,
            itemBuilder: (_, int inIndex) {
              Task task = tasksStore.entityList[inIndex];
              return ListTile(
                title: Text(task.description ?? 'bleh'),
              );
            },
          ),
        );
      },
    );
  }
}
