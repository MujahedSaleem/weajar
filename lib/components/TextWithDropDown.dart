import 'dart:ffi';

import 'package:flutter/material.dart';

class TextWithDropDown extends StatelessWidget {
  final String text;
  final int selectedValue;
  final ValueChanged<int> onChange;
  final List items;

  TextWithDropDown(
      {Key key,
      this.text,
      this.onChange,
      this.items,
      this.selectedValue})
      : assert(items != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
            child: DropdownButtonFormField<int>(
              style: TextStyle(color: Colors.white),
              value: selectedValue,
          isExpanded: true,
          onChanged: onChange,
          items: items
              .map((e) => DropdownMenuItem<int>(
                  value: e.Key,
                  child: Container(
                    width: 130,
                    child: Text(
                      e.value,
                      style: TextStyle(color: Colors.black),
                    ),
                  )))
              .toList(),
        ))
      ],
    ));
  }
}
