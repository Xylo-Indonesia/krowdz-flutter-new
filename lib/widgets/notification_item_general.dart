import 'package:badges/badges.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class NotificationItemGeneral extends StatelessWidget {
  final String title, description, dateString, timeString;
  final bool isUnread;
  final onTap;

  const NotificationItemGeneral(
      {Key key, this.title, this.description, this.isUnread, this.onTap, this.dateString, this.timeString})
      : super(key: key);

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      isUnread
                          ? Badge(
                              showBadge: true,
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              position: BadgePosition(top: 0, end: 0),
                              animationType: BadgeAnimationType.fade,
                              shape: BadgeShape.square,
                              borderRadius:BorderRadius.circular(8),
                              badgeColor: redColor,
                              badgeContent: Text(
                                'New',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ))
                          : SizedBox(
                              width: 0,
                            ),
                      SizedBox(
                        width: isUnread ? 6 : 0,
                      ),
                      Text(
                        dateString,
                        style: TextStyle(color: isUnread ? darkBackground : Colors.white),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: isUnread ? darkBackground : Colors.white),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        timeString,
                        style: TextStyle(color: isUnread ? darkBackground : Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: isUnread ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: isUnread ? darkBackground : Colors.white, fontSize: 14),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isUnread ? darkerBackground : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: isUnread ? Colors.black38 : Colors.white38,
                          blurRadius: 2,
                          spreadRadius: 0.6,
                          offset: Offset(0, 1))
                    ]),
                child: Icon(Icons.chevron_right, size: 18, color: isUnread ? Colors.white : Colors.black87),
              ),
            )
          ],
        ),
      ),
    );
  }
}
