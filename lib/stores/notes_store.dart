import 'package:mobx/mobx.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {

  // OBSERVABLES
  @observable
  String? color;

  // ACTIONS
  @action
  void setColor(String inColor){
    color = inColor;
  }

}