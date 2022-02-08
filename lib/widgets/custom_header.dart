import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'circle_button.dart';

class CustomHeader extends StatelessWidget {
  final darkMode, title, onBack, icon;

  const CustomHeader({Key key, this.darkMode = true, this.title, this.onBack, this.icon = 'assets/images/back.png'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          CircleButton(
            child: Image(image: AssetImage(icon)),
            onTap: onBack,
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: darkMode ? kTextTitle : kTextTitleDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
