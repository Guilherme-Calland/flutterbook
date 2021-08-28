import 'package:flutterbook/model/note.dart';
import 'package:mobx/mobx.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {

  // OBSERVABLES
  @observable
  int stackIndex = 0;

  @observable
  ObservableList entityList = [
    Note(title: 'test data 1'),
    Note(title: 'test data 2'),
    Note(title: 'test data 3')
  ].asObservable();

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
    entityList = await inDatabase.read();
  }

  @action
  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
  }
}