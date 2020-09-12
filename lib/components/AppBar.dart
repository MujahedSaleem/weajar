import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback actions;
  final Color iconColor;
  const CustomAppBar(
      {Key key, this.text, this.icon, this.onPressed, this.actions, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.099,
          child: InkWell(
            child: Icon(icon,color: iconColor,),
            onTap: onPressed,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
    if (actions != null)
      mainRow.children.add(SizedBox(
          width: MediaQuery.of(context).size.width * 0.099,
          child:InkWell(onTap: actions,child:  Icon(Icons.filter_list),)));
    return mainRow;
  }
}
