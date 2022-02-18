import 'package:flutter/material.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeNavButton extends StatelessWidget{
  final String? title;
  final String? imageUrl;
  final onTap;
  final color;
  final bool isActive;

  const HomeNavButton({Key? key, this.title, this.imageUrl, this.onTap, this.isActive = true, this.color = primaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text(title!.toUpperCase(), style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey,
            fontWeight: FontWeight.w600
          ),),
          Padding(padding: EdgeInsets.only(top: 12)),
          Material(
            color: isActive ? color : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                child: Image(
                  image: AssetImage(imageUrl!),
                ),
              ),
            ),
          ),
        ],
      );
  }
}