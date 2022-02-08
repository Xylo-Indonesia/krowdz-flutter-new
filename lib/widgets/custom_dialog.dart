import 'dart:ui';
import 'package:event/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, text, text2;
  final buttonColor1, buttonColor2, textColor1, textColor2;
  final Function function, function2;

  const CustomDialogBox(
      {Key key,
      this.title,
      this.text,
      this.text2,
      this.function,
      this.buttonColor1,
      this.buttonColor2,
      this.textColor1,
      this.textColor2,
      this.function2})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class Constants {
  Constants._();

  static const double padding = 10;
  static const double avatarRadius = 45;
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 4),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            gradient:
                RadialGradient(radius: 2.5, colors: [darkerBackground, Color(0xFF101010)], center: Alignment.topCenter),
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color(0xFFFAFAFA)),
              ),
              SizedBox(
                height: 22,
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: Constants.padding),
                  child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (widget.function != null) widget.function();
                          //Navigator.of(context).pop();
                        },
                        child:
                            Text(widget.text, style: TextStyle(fontWeight: FontWeight.bold, color: widget.textColor1)),
                        padding: EdgeInsets.all(18),
                        color: widget.buttonColor1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ))),
              Padding(
                  padding: EdgeInsets.only(bottom: Constants.padding),
                  child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (widget.function2 != null) widget.function2();
                        },
                        child:
                            Text(widget.text2, style: TextStyle(fontWeight: FontWeight.bold, color: widget.textColor2)),
                        padding: EdgeInsets.all(18),
                        color: widget.buttonColor2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ))),
            ],
          ),
        ),
        // Positioned(
        //   left: Constants.padding,
        //   right: Constants.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: Constants.avatarRadius,
        //     child: ClipRRect(
        //         borderRadius:
        //             BorderRadius.all(Radius.circular(Constants.avatarRadius)),
        //         child: Image.asset("assets/model.jpeg")),
        //   ),
        // ),
      ],
    );
  }
}
