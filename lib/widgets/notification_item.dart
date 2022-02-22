import 'package:badges/badges.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:event/services/consts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final String? title, message, type, createdAt;
  final bool? isUnread;

  const NotificationItem(
      {Key? key,
      this.title,
      this.message,
      this.isUnread,
      this.type,
      this.createdAt})
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
                  Observer(builder: (_) {
                    if (type == 'general') {
                      List<Widget> row = [];

                      if (isUnread!) {
                        row.add(Badge(
                            showBadge: isUnread!,
                            shape: BadgeShape.square,
                            badgeColor: redColor,
                            borderRadius: BorderRadius.circular(10),
                            badgeContent: const Text(
                              'New',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )));

                        row.add(const SizedBox(width: 5));
                      }

                      row.add(Text(
                        DateFormat('dd MMM yyyy | HH:mm')
                            .format(DateTime.parse(createdAt!)),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ));

                      return Row(
                        children: row,
                      );
                    }

                    return Container();
                  }),
                  const SizedBox(height: 6),
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: isUnread! ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 6),
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
            Observer(builder: (_) {
              if (type == 'announcement') {
                return Badge(
                    showBadge: isUnread!,
                    padding: const EdgeInsets.all(6),
                    position: const BadgePosition(top: 0, end: 0),
                    badgeColor: redColor);
              } else {
                if (isUnread!) {
                  return const Image(
                      image: AssetImage(
                    'assets/images/chevron-circle-right-dark.png',
                  ));
                }

                return const Image(
                    image: AssetImage(
                  'assets/images/chevron-circle-right-light.png',
                ));
              }
            })
          ],
        ),
      ),
    );
  }
}
