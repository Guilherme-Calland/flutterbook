import 'package:mobx/mobx.dart';

part 'base_store.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {

  // OBSERVABLES
  @observable
  int stackIndex = 0;

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
  loadData(dynamic inDatabase) async {
    entityList = await inDatabase.read();
    print(entityList);
  }

  @action
  void setStackIndex(int inStackIndex){
    stackIndex = inStackIndex;
  }
}