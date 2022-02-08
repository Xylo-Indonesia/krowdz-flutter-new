import 'package:event/services/utilities.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardVisitors extends StatelessWidget {
  final int visitor1, visitor2;
  final color, onTap, isLoading;
  final String title;

  const CardVisitors(
      {Key key,
      this.visitor1,
      this.visitor2,
      this.color,
      this.title,
      this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: textGray, fontSize: 14.sp),
                      ),
                      isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                enabled: true,
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              Util.numberFormat(visitor1),
                              style: kTextPrimaryColored(color),
                            ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black12,
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(color),
                              value: (visitor1 == 0 && visitor2 == 0)
                                  ? 0
                                  : (visitor1 / (visitor1 + visitor2)),
                              strokeWidth: 3,
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          isLoading
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  enabled: true,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  ((visitor1 == 0 && visitor2 == 0)
                                          ? 0
                                          : (visitor1 /
                                              (visitor1 + visitor2) *
                                              100))
                                      .floor()
                                      .toString(),
                                  style: TextStyle(color: color, fontSize: 16.sp),
                                ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '%',
                            style: TextStyle(color: color, fontSize: 12.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2,
                                spreadRadius: 0.6,
                                offset: Offset(0, 1))
                          ]),
                      child: Icon(Icons.chevron_right,
                          size: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
