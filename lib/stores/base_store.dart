import 'package:flutterbook/model/note.dart';
import 'package:mobx/mobx.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {

  // OBSERVABLES
  @observable
  int stackIndex = 0;

  // @observable
  // ObservableList entityList = [
  //   Note(id: 1, color: 'green', title: 'test data 1'),
  //   Note(id: 2, color: 'yellow', title: 'test data 2'),
  //   Note(id: 3, color: 'blue', title: 'test data 3')
  // ].asObservable();

  @observable
  List entityList = [];

  @observable
  var entityBeingEdited;

  @observable
  String chosenDate = '';

  // ACTIONS
  @action
  void setChosenDate(String inDate){
    chosenDate = inDate;
  }

  @action
  Future<void> loadData(dynamic inDatabase) async {
    List<Map<String, dynamic>> rawData = await inDatabase.read();
    //solução temporaria
    List<Note> notesList = [];
    rawData.forEach((element) {
      Note tempNote = Note.mapToNote(element);
      notesList.add(tempNote);
    });
    entityList = notesList;
  }

  @action
  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
  }
}