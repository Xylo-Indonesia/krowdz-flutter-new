import 'package:badges/badges.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:event/services/consts.dart';

class NotificationItem extends StatelessWidget {
  final String? title, message;
  final bool? isUnread;

  const NotificationItem({Key? key, this.title, this.message, this.isUnread})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(notificationDetailPage);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white, width: 1, style: BorderStyle.solid),
            color: isUnread! ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 19),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: isUnread! ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    message!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: isUnread! ? darkBackground : Colors.white,
                        fontSize: 14),
                  )
                ],
              ),
            ),
            Badge(
                showBadge: isUnread!,
                padding: const EdgeInsets.all(6),
                position: const BadgePosition(top: 0, end: 0),
                badgeColor: redColor)
          ],
        ),
      ),
    );
  }
}
