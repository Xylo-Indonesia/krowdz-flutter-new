import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class NotificationDetail extends StatefulWidget {
  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      darkMode: false,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: CustomHeader(
                    darkMode: false,
                    title: "General",
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                          ),
                          Text("Keep up the good work.", style: kTextTitleDark),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1))),
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        width: ScreenUtil().setSp(60),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/wuling.png'),
                                        )
                                        // FadeInImage.memoryNetwork(
                                        //     placeholder: kTransparentImage,
                                        //     image: 'https://placehold.it/100'),
                                        ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Admin Wuling",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: darkBackground),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "31 Aug 2020",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "|",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "21:00",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("to:"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "PIC_SPK",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                              Text(
                                                ", ",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                              Text(
                                                "PIC_SPK",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dapibus ultrices in iaculis nunc sed augue lacus. Quam nulla porttitor massa id neque aliquam. Ultrices mi tempus imperdiet nulla malesuada. Eros in cursus turpis massa tincidunt dui ut ornare lectus. Egestas sed sed risus pretium. Lorem dolor sed viverra ipsum. Gravida rutrum quisque non tellus. Rutrum tellus pellentesque eu tincidunt tortor. Sed blandit libero volutpat sed cras ornare. Et netus et malesuada fames ac. Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Lacus sed viverra tellus in. Sollicitudin ac orci phasellus egestas. Purus in mollis nunc sed. Sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque. Interdum consectetur libero id faucibus nisl tincidunt eget.",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.grey[700]),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1))),
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        width: ScreenUtil().setSp(60),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/wuling.png'),
                                        )
                                        // FadeInImage.memoryNetwork(
                                        //     placeholder: kTransparentImage,
                                        //     image: 'https://placehold.it/100'),
                                        ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Crew Wuling",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: darkBackground),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "31 Aug 2020",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "|",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "21:00",
                                                style: TextStyle(
                                                    color: darkBackground),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "ok mantap",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.grey[700]),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Reply.."),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      FlatButton(
                          child: Image(
                              image: AssetImage('assets/images/send.png')),
                          shape: CircleBorder(),
                          color: redColor,
                          minWidth: 0,
                          padding: EdgeInsets.all(16),
                          onPressed: () {
                            print("asd");
                          }),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
