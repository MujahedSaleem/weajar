import 'package:flutter/material.dart';
import 'package:weajar/model/Isearch.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T selectedValue;
  final BorderRadius radius;
  final Color color;
  final ValueChanged<T> onChange;
  final List<FiealdSearch> items;

  CustomDropDown(
      {Key key,
      this.selectedValue,
      this.items,
      this.onChange,
      this.color,
      this.radius})
      : assert(items != null);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: radius, color: color),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<T>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    value: selectedValue,
                    isExpanded: true,
                    onChanged: onChange,
                    items: items
                        .map((FiealdSearch e) => DropdownMenuItem<T>(
                            value: e.Key,
                            child: Container(
                              width: 130,
                              child: Text(
                                e.value,
                              ),
                            )))
                        .toList()))));
  }
}
