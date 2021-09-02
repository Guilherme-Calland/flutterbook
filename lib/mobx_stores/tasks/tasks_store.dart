import 'package:flutterbook/mobx_stores/base_store.dart';
import 'package:mobx/mobx.dart';

part 'tasks_store.g.dart';

class TasksStore = _TasksStore with _$TasksStore;

abstract class _TasksStore extends BaseStore with Store {

}