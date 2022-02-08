import 'package:flutter/material.dart';

class CustomPin extends StatelessWidget{
  final String char;
  final bool fieldFocused, itemFocused;

  const CustomPin({Key key, this.char, this.fieldFocused, this.itemFocused}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: char.isEmpty ? Colors.transparent : Colors.white,
        border: Border.all(width: 1, color: Colors.white)
      ),
    );
  }
}