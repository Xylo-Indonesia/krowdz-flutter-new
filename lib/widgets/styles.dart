import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

const bodyPadding = 20.0;
const lightBackground = Color(0xFFEDEDED);
const darkBackground = Color(0xFF464646);
const darkerBackground = Color(0xFF242424);
const primaryColor = Color(0xFF4C29C1);
const redColor = Color(0xFFBA1134);
const yellowColor = Color(0xFFFFC100);

const textGray = Color(0xFF989898);

var kTextWhite = TextStyle(color: Colors.white);

var kTextPrimary1 = TextStyle(
    fontSize: ScreenUtil().setSp(40),
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1);

var kTextPrimary2 = TextStyle(
    fontSize: ScreenUtil().setSp(20),
    fontWeight: FontWeight.bold,
    color: primaryColor);

var kTextTitle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(20));

var kTextTitleDark =
    TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(20));
var kTextTitleRed = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(16),
    color: redColor);

var kTextTitleLarge = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(20));

var kTextTitleLargeDark =
    TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(20));

TextStyle kTextPrimaryColored(color) {
  print("40:" +
      ScreenUtil().setSp(40).toString() +
      ", ScaleText:" +
      ScreenUtil().scaleText.toString() +
      // ", Allow Scale:" +
      // ScreenUtil().allowFontScaling.toString() +
      ", ScaleFactor:" +
      ScreenUtil().textScaleFactor.toString());
  return TextStyle(
      fontSize: ScreenUtil().setSp(40),
      fontWeight: FontWeight.bold,
      color: color,
      height: 1.1);
}

var kTextBanner = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: ScreenUtil().setSp(25),
);

kTextLink(BuildContext context) => TextStyle(
    fontSize: ScreenUtil().setSp(15),
    color: Theme.of(context).primaryColorDark,
    fontWeight: FontWeight.w600);

class LightShimmer extends StatelessWidget {
  final double? width, height;

  const LightShimmer({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      );
}

class DarkShimmer extends StatelessWidget {
  final double? width, height;

  const DarkShimmer({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[800]!,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        color: darkBackground,
      ),
    );
  }
}
