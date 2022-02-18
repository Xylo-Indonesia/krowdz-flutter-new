import 'package:badges/badges.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationType extends StatelessWidget {
  final String? title;
  final bool isActive;
  final onTap, badge;

  const NotificationType({Key? key, this.title, this.isActive = false, this.onTap, this.badge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1, style: BorderStyle.solid),
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!,
                style: TextStyle(color: isActive ? darkerBackground : Colors.white, fontWeight: FontWeight.bold),
              ),
              badge
            ],
          ),
        ),
      ),
    );
  }
}
