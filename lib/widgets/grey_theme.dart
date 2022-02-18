import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class GrayTheme extends StatelessWidget {
  final child, darkMode;

  const GrayTheme({Key? key, this.child, this.darkMode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Container(

        decoration: BoxDecoration(
          color: Color(0xFFEDEDED )

        ),
        child: child,
      );


  }
}
