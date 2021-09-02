import 'package:flutterbook/mobx_stores/base_store.dart';
import 'package:mobx/mobx.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore extends BaseStore with Store{

  //OBSERVABLE
  @observable
  String? color;

  //ACTION
  @action
  void setColor(String? inColor){
    color = inColor;
  }
}