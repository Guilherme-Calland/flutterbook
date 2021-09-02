import 'package:flutterbook/model/note.dart';
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
  setChosenDate(String inDate){
    chosenDate = inDate;
  }

  @action
  Future<void> loadData(dynamic inDatabase) async{
    List<Map<String, dynamic>> rawData = await inDatabase.read();
    //temporary solution
    List<Note> noteList = [];
    rawData.forEach((element){
      Note n = Note.mapToNote(element);
      noteList.add(n);
    });
    entityList = noteList;
  }

  @action
  void setStackIndex(int index){
    stackIndex = index;
  }

}