import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pagination extends StatefulWidget {
  final leftOnTap, rightOnTap, numberOnTap, pages,hasPrev,hasNext;

  const Pagination(
      {Key key,this.hasPrev,this.hasNext ,this.pages, this.leftOnTap, this.rightOnTap, this.numberOnTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaginationState();
  }
}

class PaginationState extends State<Pagination> {
  Widget renderPages(length) {
    Row result = Row(children: []);

    for (var i = 0; i < length; i++) {
      var page = GestureDetector(
        onTap: widget.numberOnTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            (i + 1).toString(),
            style: TextStyle(fontSize: 24.sp, color: Colors.white),
          ),
        ),
      );
      result.children.add(page);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: widget.leftOnTap,
          child: Padding(
            padding: EdgeInsets.all(4),
            child:
            Opacity(opacity: widget.hasPrev?1:0,
              child:Image(
                image: AssetImage('assets/images/chevron-circle.png'),
              ),
              ),

          ),
        ),
        widget.pages,
        GestureDetector(
          onTap: widget.rightOnTap,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Transform(
              transform: Matrix4.rotationY(math.pi),
              alignment: Alignment.center,
              child:
              Opacity(
                opacity: widget.hasNext?1:0,
                child:Image(
                  image: AssetImage('assets/images/chevron-circle.png'),
                ) ,
              ),

            ),
          ),
        )
      ],
    );
  }
}
