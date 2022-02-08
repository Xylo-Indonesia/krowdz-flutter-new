import 'package:event/services/utilities.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TotalVisitors extends StatelessWidget {
  final int visitor1, visitor2;
  final String date;
  final isLoading, isAdmin;

  const TotalVisitors(
      {Key key,
      this.visitor1,
      this.visitor2,
      this.date,
      this.isLoading = true,
      this.isAdmin = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4212121),
              border: Border.all(
                  width: 2, color: Colors.white, style: BorderStyle.solid)),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SizedBox(
              width: double.infinity * 0.9,
              child: CircularProgressIndicator(
                value: (visitor1 == 0 && visitor2 == 0)
                    ? 0
                    : (visitor2 / (visitor1 + visitor2)).toDouble(),
                backgroundColor: redColor,
                strokeWidth: 14,
                valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/group.png')),
              Text(
                "Total Visitors",
                style: TextStyle(color: textGray),
              ),
              isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[850],
                        highlightColor: Colors.grey[800],
                        enabled: true,
                        child: Container(
                          width: 100,
                          height: 34,
                          color: darkerBackground,
                        ),
                      ),
                    )
                  : Text(
                      Util.numberFormat(visitor1 + visitor2),
                      style: kTextPrimary1,
                    ),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[850],
                      highlightColor: Colors.grey[800],
                      enabled: true,
                      child: Container(
                        width: 80,
                        height: 14,
                        color: isAdmin ? Colors.transparent : darkerBackground,
                      ),
                    )
                  : Text(
                      isAdmin ? "" : date,
                      style: TextStyle(
                          color: textGray, fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
