import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final child, padding, darkMode;

  const CustomInput({Key key, this.label, this.child, this.padding = const EdgeInsets.all(0), this.darkMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    label,
                    style: TextStyle(color: darkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              : SizedBox(width: 0),
          child
        ],
      ),
    );
  }
}
