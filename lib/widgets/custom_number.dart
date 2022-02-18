import 'package:code_field/code_field.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNumber extends StatefulWidget {
  final InputCodeControl? codeControl;
  final String? char, type;

  const CustomNumber({Key? key, this.codeControl, this.char, this.type = 'text'}) : super(key: key);

  @override
  _CustomNumberState createState() => _CustomNumberState();
}

class _CustomNumberState extends State<CustomNumber> {
  bool isPressed = false;
  Widget renderContent(String? type) {
    Widget result;
    switch (type) {
      case 'text':
        result = Text(
          widget.char!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
        );
        break;
      case 'delete':
        result = Icon(Icons.backspace, color: Colors.white, size: 24);
        break;
      case 'empty':
        result = Text(
          "   ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
        );
        break;
      default:
        result = Text(
          widget.char!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36),
        );
        break;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 26),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: isPressed
                    ? [
                        redColor,
                        primaryColor,
                      ]
                    : [Colors.transparent, Colors.transparent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: renderContent(widget.type)),
      onTap: () {
        switch (widget.type) {
          case 'text':
            widget.codeControl!.value = (widget.codeControl!.value.toString() + widget.char!);
            break;
          case 'delete':
            if (widget.codeControl!.value != null && (widget.codeControl!.value.length > 0)) {
              widget.codeControl!.value = widget.codeControl!.value.substring(0, widget.codeControl!.value.length - 1);
            }
            break;
          case 'empty':
            break;
        }
      },
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
    );
  }
}
