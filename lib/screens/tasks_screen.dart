import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterbook/screens/tasks_entry.dart';
import 'package:flutterbook/screens/tasks_list.dart';
import '../utils.dart';

class TasksScreen extends StatelessWidget {

  TasksScreen(){
    tasksStore.loadData('tasks', tasksDB);
  }

  @override
  Widget build(_){
    return Observer(
      builder: (_){
        return IndexedStack(
          index: 0,
          children: [
            TasksList(),
            TasksEntry(),
          ],
        );
      },
    );
  }
}
