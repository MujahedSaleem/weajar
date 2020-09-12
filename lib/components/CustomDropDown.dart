import 'package:flutter/material.dart';
import 'package:weajar/model/Isearch.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T selectedValue;
  final BorderRadius radius;
  final Color color;
  final ValueChanged<T> onChange;
  final List<FiealdSearch> items;
  final double hight;
  final double width;
  final String label;
  CustomDropDown(
      {Key key,
      this.selectedValue,
      this.items,
      this.onChange,
      this.color,
      this.radius,
      this.hight,
      this.width, this.label})
      : assert(items != null);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? 128,
        height: hight ?? 56,
padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(20) ),
        child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<T>(
                    itemHeight: 55,
                    isDense: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius:radius ),
                      contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                      labelText: label,
                      labelStyle: TextStyle(fontSize: 18)
                    ),
                    value: selectedValue,
                    isExpanded: true,
                    onChanged: onChange,
                    items: items
                        .map((FiealdSearch e) => DropdownMenuItem<T>(
                            value: e.Key,
                            child: Container(
                              height: hight ?? 30,
                              child: Text(
                                e.value,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )))
                        .toList())));
  }
}
