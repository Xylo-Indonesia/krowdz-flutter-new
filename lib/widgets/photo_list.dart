import 'package:badges/badges.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoList extends StatelessWidget {
  final image, onTap;

  const PhotoList({Key key, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Badge(
            badgeColor: redColor,
            animationType: BadgeAnimationType.fade,
            badgeContent: Icon(
              Icons.close,
              color: Colors.white,
              size: 16,
            ),
            child: Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius: 0.6, offset: Offset(0, 1))],
                  color: Colors.white),
              child: Image(
                image: FileImage(image),
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
