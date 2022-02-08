import 'package:badges/badges.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title, description;
  final bool isUnread;
  final onTap;

  const NotificationItem({Key key, this.title, this.description, this.isUnread, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1, style: BorderStyle.solid),
            color: isUnread ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 19),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: isUnread ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  description,
                  style: TextStyle(color: isUnread ? darkBackground : Colors.white, fontSize: 14),
                )
              ],
            ),
            Badge(
                showBadge: isUnread,
                padding: EdgeInsets.all(6),
                position: BadgePosition(top: 0, end: 0),
                badgeColor: redColor)
          ],
        ),
      ),
    );
  }
}
