import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../utils.dart';

class ColorSticker extends StatelessWidget {
  final String inColorName;
  final Color inColor;

  ColorSticker({required this.inColor, required this.inColorName});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return GestureDetector(
          onTap: () {
            notesStore.entityBeingEdited.color = inColorName;
            notesStore.setColor(inColorName);
          },
          child: Container(
            decoration: ShapeDecoration(
              shape: Border.all(
                width: 18,
                color: inColor,
              ) +
              Border.all(
                width: 6,
                color:
                    notesStore.color == inColorName ? inColor: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
