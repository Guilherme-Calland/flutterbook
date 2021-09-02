import 'package:flutter/material.dart';
import 'package:flutterbook/database/notes_db_worker.dart';
import 'mobx_stores/notes/notes_store.dart';

// Future selectDate(
//   BuildContext inContext, BaseStore inStore, String inDateString
// ) async {
//   DateTime initialDate = DateTime.now();
//
//   if(inDateString != null){
//     List dateParts = inDateString.split(',');
//     initialDate = DateTime(
//       int.parse(dateParts[0]),
//       int.parse(dateParts[1]),
//       int.parse(dateParts[2])
//     );
//   }
//
//   DateTime? picked = await showDatePicker(
//     context: inContext, initialDate: initialDate,
//     firstDate: DateTime(1900), lastDate : DateTime(2100)
//   );
//
//   if(picked != null) {
//     inStore.setChosenDate(
//       DateFormat.yMMMMd('en_US').format(picked.toLocal(),)
//     );
//     return '${picked.year}, ${picked.month}, ${picked.day}';
//   }
// }

NotesDBWorker notesDB = NotesDBWorker();
NotesStore notesStore = NotesStore();

Future<void> testDeleting() async {
  int? result = await notesDB.delete(2);
  result != null ?
  print('$result item was deleted successfully!')
      :
  print('something went wrong in deleting the data');
}

String? validateText(String? inValue, String message) {
  if(inValue != null){
    if(inValue.length > 0){
      return null;
    }
  }
  return message;
}

Future<void> testingCreation() async {
  var data = {
    'title' : 'testTitle',
    'content' : 'testContext',
    'color' : 'testColor'
  };

  int? result = await notesDB.create(data);
  if(result != null){
    print('data of id $result was successfully saved');
  }else{
    print('result on creation returned null');
  }
}

Future<void> testingReading() async {
  var result = await notesDB.get(2);
  print(result);
}

Future<void> testReadingAll() async {
  List? result = await notesDB.read();
  if(result != null){
    result.forEach((map){
      print(map);
    });
  } else {
    print('result came in null :(');
  }
}

Future<void> testUpdating() async {
  Map<String, dynamic> newData = {
    'id' : 3,
    'title' : 'new edited title',
  };
  int? result = await notesDB.update(newData);
  if(result != null){
    print('data of id $result was updates');
  }else{
    print('data was called on null (update)');
  }
}

void hideKeyboard(BuildContext inContext) {
  FocusScope.of(inContext).requestFocus(FocusNode());
}

void showSnackBar(BuildContext inContext, {Color? inColor, required String inText}) {
  SnackBar snack = SnackBar(
    backgroundColor: inColor ?? Colors.grey,
    duration: Duration(seconds: 2),
    content: Text(inText),
  );
  ScaffoldMessenger.of(inContext).showSnackBar(snack);
}

void toBeImplemented(){
  print('to be implemented...');
}

void popNavigator(BuildContext inAlertContext) {
  Navigator.of(inAlertContext).pop();
}