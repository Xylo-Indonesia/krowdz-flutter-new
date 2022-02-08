import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationNumber extends StatelessWidget {
  final onTap, number, isSelected;

  const PaginationNumber(
      {Key key, this.number, this.onTap, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          number.toString(),
          style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
