import 'package:event/model/ArgumentNewActivity.dart';
import 'package:event/model/activity.dart';
import 'package:event/model/activity.dart';
import 'package:event/model/activity.dart';
import 'package:event/model/activity.dart';
import 'package:event/model/activity_history.dart';
import 'package:event/model/visitor.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/utilities.dart';
import 'package:event/stores/visitor_detail.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/styles.dart';
import 'package:event/widgets/table_child.dart';
import 'package:event/widgets/table_header.dart';
import 'package:event/widgets/visitor_detail_activity.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitorDetail extends StatefulWidget {
  final String example;
  dynamic visitor;
  // const VisitorDetail({Key key, this.example = "VisitorDetail",var arguments})
  //     : super(key: key);

  VisitorDetail({Key key, this.example = "VisitorDetail", var arguments}) {
    //print("arguments:"+arguments.toString());
    visitor = arguments;
  }

  @override
  State<StatefulWidget> createState() {
    return VisitorDetailState(visitor);
  }
}

class VisitorDetailState extends State<VisitorDetail> {
  VisitorDetailStore store = VisitorDetailStore();
  dynamic visitor;
  VisitorDetailState(dynamic visitor) {
    store.getVisitor(visitor["id"].toString());
    this.visitor = visitor;

    store.getActivity();
  }

  refresh() async{
    store.getVisitor(visitor["id"].toString());
  }

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
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                  child: CustomHeader(
                    darkMode: false,
                    title: "Visitor Detail",
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                            child: Column(
                              children: [
                                ExpandablePanel(
                                  controller: ExpandableController(initialExpanded: true),
                                  header: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text(
                                      "" + visitor["name"],
                                      style: kTextTitleLargeDark,
                                    ),
                                  ),
                                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                                  expanded: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border: Border(top: BorderSide(color: Colors.grey, width: 2))),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Observer(builder: (_) {
                                      if (store.isDataReady) {
                                        Column col = Column(
                                          children: [],
                                        );
                                        var i = 0;
                                        Row row = null;
                                        store.jsonResponse["meta"]["keymapper"].forEach((k, v) {
                                          print(k.toString() + ":" + v.toString());

                                          if (row == null)
                                            row = Row(
                                              children: [],
                                            );

                                          Expanded e = Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "" + v.toString(),
                                                    style:
                                                        TextStyle(fontSize: 12.sp),
                                                  ),
                                                  Text(
                                                    store.jsonResponse["data"][k.toString()], //"1241 AFK 77A",
                                                    style: kTextTitleRed,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                          row.children.add(e);
                                          if (i % 2 == 1) {
                                            col.children.add(row);
                                            row = null;
                                          }
                                          i++;
                                        });
                                        return col;
                                      } else {
                                        return Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(darkBackground),
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                  collapsed: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey, width: 12)),
                                      )),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ))),
                                  child: Text(
                                    "Activity Form",
                                    style: kTextTitleDark,
                                  ),
                                ),
                                Observer(builder:(_){
                                  if(null!=store.ac){
                                    Column col = Column(
                                      children: [],
                                    );

                                    for(var activity in store.ac.data){
                                      var visitorDetailActivity=VisitorDetailActivity(
                                          image: Util.getActivityIcon(activity.name),
                                          title: activity.name,
                                          onTap: () {
                                            print("games"+activity.id.toString());
                                            ArgumentNewActivity args=ArgumentNewActivity();
                                            args.activity=activity;
                                            args.visitor=visitor;
                                            Navigator.of(context).pushNamed(newActivityPage, arguments: args)
                                                .then((_)=>{
                                                    refresh()

                                                }
                                            );
                                          },
                                        );
                                      col.children.add(visitorDetailActivity);
                                    }
                                    return col;
                                  }

                                  return Container();
                                }),

                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    "History",
                                    style: kTextTitleDark,
                                  ),
                                ),
                                TableHeader(
                                  isGradient: false,
                                  backgroundColor: Colors.black54,
                                  childLeft: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: Text("Activity", style: kTextTitle)),
                                  childRight: Text("Date and Time", style: kTextTitle),
                                  flexLeft: 1,
                                  flexRight: 1,
                                ),
                                Observer(builder:(_){
                                  if(null!=store.jsonResponse && null!=store.jsonResponse["data"]["history"]["data"]){
                                    var col=Column(children: [],);
                                    for(var h in store.jsonResponse["data"]["history"]["data"]){
                                      var tableChild=TableChild(
                                        backgroundColor: Colors.black12,
                                        borderColor: Colors.grey,
                                        darkMode: true,
                                        childLeft: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              h["name"],// "Games",
                                              style: kTextTitleDark,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              h["product"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                  height: 1.1),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        childRight: Text(
                                          Util.dateFormat(h["created_at"]),//'27/09/2020 | 10:30',
                                          style: TextStyle(color: Colors.black45),
                                        ),
                                        flexLeft: 1,
                                        flexRight: 1,
                                        onTap: () {
                                          // class ActData {
                                          //   int id;
                                          //   String name;
                                          // }
                                          print("Edit History Activity");
                                          ArgumentNewActivity args=ArgumentNewActivity();
                                          ActivityHistoryData activity=ActivityHistoryData();
                                          activity.id=1;
                                          activity.name="Test Drive";
                                          args.activity=activity;
                                          args.visitor=visitor;
                                          args.isEdit=true;
                                          args.activityHistory=h;
                                          Navigator.of(context).pushNamed(newActivityPage, arguments: args)
                                              .then((_)=>{
                                            refresh()

                                          }
                                          );
                                        },
                                      );
                                      col.children.add(tableChild);

                                    }
                                    return col;

                                  }


                                  return Container();
                                }
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
