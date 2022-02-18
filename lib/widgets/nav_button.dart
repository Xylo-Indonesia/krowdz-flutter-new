import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavButton extends StatelessWidget {
  final String? title;
  final onTap, image;

  const NavButton({Key? key, this.title, this.onTap, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF242424),
              border: Border.all(color: Color(0xFF454545))),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image(
                  image: AssetImage(image),
                  width: 30,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onTap,
                  ),
                ),
              )
            ],
          ),
        ),
        Text(
          title!,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
