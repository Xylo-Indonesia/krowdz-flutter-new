import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final child, onTap, darkMode;

  const CircleButton({Key key, this.onTap, this.child, this.darkMode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF242424),
            border: Border.all(color: Color(0xFF454545)),
            boxShadow: [
              BoxShadow(
                  color: darkMode ? Colors.black38 : Colors.white38,
                  blurRadius: 2,
                  spreadRadius: 0.6,
                  offset: Offset(0, 1))
            ]),
        child: child,
      ),
      onTap: onTap,
    );
  }
}
