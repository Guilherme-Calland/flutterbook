import 'package:flutterbook/stores/base_store.dart';
import 'package:mobx/mobx.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore extends BaseStore with Store{

  // OBSERVABLES
  @observable
  String? color;

  // ACTIONS
  @action
  void setColor(String? inColor){
    color = inColor;
  }

  @action
  void testingStoreFunctionality(){
    print('hello?, is it me your looking for?');
  }
}