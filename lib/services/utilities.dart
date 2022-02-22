import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int?, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch as Map<int, Color>);
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Util {
  static String numberFormat(var number) {
    var f = new NumberFormat("#,###", "id_ID");
    return f.format(number);
  }
  // static String getActivityIcon(var name){
  //     switch(name){
  //       case 'Games': return 'assets/images/games-dark.png';break;
  //       case 'Test Drive': return 'assets/images/car-dark.png';break;
  //       case 'SPK': return 'assets/images/spk-dark.png';break;
  //       default: return 'assets/images/games-dark.png';break;
  //     }
  // }

  static String getActivityIconDark(var icon) {
    return (icon != null && icon != '')
        ? 'assets/images/' + icon + '-dark.png'
        : 'assets/images/games-dark.png';
  }

  static String getActivityIconLight(var icon) {
    return (icon != null && icon != '')
        ? 'assets/images/' + icon + '-light.png'
        : 'assets/images/games-dark.png';
  }

  static String dateFormat(var date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat dateFormat =
        DateFormat("dd/MM/yyyy | HH:mm"); //("yyyy-MM-dd HH:mm:ss");
    return dateFormat.format(dateTime);
  }
}
