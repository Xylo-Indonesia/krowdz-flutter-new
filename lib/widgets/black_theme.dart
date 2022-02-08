import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class BlackTheme extends StatelessWidget {
  final child, darkMode;

  const BlackTheme({Key key, this.child, this.darkMode = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: darkMode
                ? [Color(0xFF3B3B3B), Color(0xFF101010)]
                : [lightBackground, lightBackground],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
          image: DecorationImage(
              image: AssetImage(darkMode
                  ? 'assets/images/bg-lock-dark.png'
                  : 'assets/images/bg-lock.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter),
        ),
        child: child,
      );


  }
}
