import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class AdminCalendar extends StatelessWidget {
  final String? date;
  final onTap;

  const AdminCalendar({Key? key, this.date, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: darkerBackground,
                    border: Border.all(color: darkBackground, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 4)),
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            date!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image(
                        height: 18,
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/images/iconmonstr-calendar-4.png'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
