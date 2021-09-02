import 'package:flutterbook/model/note.dart';
import 'package:flutterbook/model/task.dart';
import 'package:mobx/mobx.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  //OBSERVABLE
  @observable
  var entityBeingEdited;

  @observable
  int stackIndex = 0;

  @observable
  List entityList = [];

  @observable
  String chosenDate = '';

  //ACTIONS
  @action
  setChosenDate(String inDate) {
    chosenDate = inDate;
  }

  @action
  Future<void> loadData(String inType, dynamic inDatabase) async {
    List<Map<String, dynamic>> rawData = await inDatabase.read();
    entityList = convertToSpecificType(inType, rawData);
  }

  List convertToSpecificType(String inType, List rawData){
    List<dynamic> tempEntityList = [];
    rawData.forEach(
          (element) {
        dynamic entity;
        switch (inType) {
          case 'notes':
            entity = Note.mapToNote(element);
            break;
          case 'tasks':
            entity = Task.mapToTask(element);
            break;
        }
        tempEntityList.add(entity);
      },
    );
    return tempEntityList;
  }

  @action
  void setStackIndex(int index) {
    stackIndex = index;
  }
}
