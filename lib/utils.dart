import 'package:flutter/material.dart';
import 'package:flutterbook/stores/base_store.dart';
import 'package:intl/intl.dart';

Future selectDate(
  BuildContext inContext, BaseStore inStore, String inDateString
) async {
  DateTime initialDate = DateTime.now();

  if(inDateString != null){
    List dateParts = inDateString.split(',');
    initialDate = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2])
    );
  }

  DateTime? picked = await showDatePicker(
    context: inContext, initialDate: initialDate,
    firstDate: DateTime(1900), lastDate : DateTime(2100)
  );

  if(picked != null) {
    inStore.setChosenDate(
      DateFormat.yMMMMd('en_US').format(picked.toLocal(),)
    );
    return '${picked.year}, ${picked.month}, ${picked.day}';
  }
}

