import 'package:event/model/arguments_visitor.dart';
import 'package:event/model/keymap.dart';
import 'package:event/services/consts.dart';
import 'package:event/stores/visitor_list_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/circle_button.dart';
import 'package:event/widgets/custom_dropdown.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/pagination.dart';
import 'package:event/widgets/pagination_number.dart';
import 'package:event/widgets/select_screen.dart';
import 'package:event/widgets/styles.dart';
import 'package:event/widgets/table_child.dart';
import 'package:event/widgets/table_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:validators/validators.dart';

class VisitorList extends StatefulWidget {
  ArgumentVisitor arguments;
  VisitorList({ArgumentVisitor arguments = null}) {
    this.arguments = arguments;
  }

  @override
  State<StatefulWidget> createState() {
    return VisitorListState(arguments: arguments);
  }
}

class VisitorListState extends State<VisitorList> {
  VisitorListStore vStore = VisitorListStore();
  ArgumentVisitor args;
  VisitorListState({ArgumentVisitor arguments}) {
    args = arguments;
    if (null != args) {
      vStore.getVisitorList(
          keyword: args.keyword, keyword_by: args.keyword_by, page: '1');
      vStore.keyword = args.keyword;
    } else
      vStore.getVisitorList(keyword: '', keyword_by: '', page: '1');
  }

  String selectedType = '';
  String selectedType2 = '';

  final List<String> items = <String>[
    '',
    // 'Main Bola',
    // 'Makan Beling Bersama Teman-Teman',
    // 'Makan Temen'
  ];
  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CustomHeader(
                    onBack: () {
                      Navigator.of(context).pop();
                    },
                    darkMode: true,
                    title: "Visitor List",
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              CustomInput(
                                darkMode: true,
                                label: "",
                                child: Observer(builder: (_) {
                                  if (null != vStore.selectedKey) {
                                    if (vStore.selectedKey == null)
                                      vStore.selectedKey = vStore.items[0];
                                    return CustomDropdown(
                                      widgetSelectedType: vStore.selectedKey,
                                      itemList: vStore.items,
                                      onClick: (value) {
                                        setState(() {
                                          vStore.selectedKey = value;
                                        });

                                        if (value.key == 'online' ||
                                            value.key == 'offline' ||
                                            value.key.contains('activity')) {
                                          vStore.getVisitorList(
                                            keyword_by: value.key,
                                          );
                                        }
                                        ;
                                      },
                                    );
                                  }

                                  return DarkShimmer(
                                    width: double.infinity,
                                    height: 56.0,
                                  );
                                }),
                              ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(horizontal: 16),
                              //   decoration:
                              //       BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(16)),
                              //   child: DropdownButtonHideUnderline(
                              //     child: Observer(builder: (_) {
                              //       if (null != vStore.selectedKey) {
                              //         if (vStore.selectedKey == null) vStore.selectedKey = vStore.items[0];
                              //         return DropdownButton(
                              //           value: vStore.selectedKey,
                              //           isExpanded: true,
                              //           items: vStore.items.map((KeyMap item) {
                              //             return DropdownMenuItem<KeyMap>(
                              //               child: Text(
                              //                 item.value,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 maxLines: 1,
                              //               ),
                              //               value: item,
                              //             );
                              //           }).toList(),
                              //           onChanged: (value) {
                              //             setState(() {
                              //               vStore.selectedKey = value;
                              //             });
                              //           },
                              //         );
                              //       }

                              //       return DropdownButton(
                              //         value: selectedType2,
                              //         isExpanded: true,
                              //         items: items.map((String item) {
                              //           return DropdownMenuItem<String>(
                              //             child: LightShimmer(
                              //               width: 200,
                              //               height: 30,
                              //             ),
                              //             value: item,
                              //           );
                              //         }).toList(),
                              //         onChanged: (value) {
                              //           setState(() {});
                              //         },
                              //       );
                              //     }),
                              //   ),
                              // ),
                              Observer(builder: (_) {
                                // if(null==vStore.selectedKey){
                                //   return CustomInput(
                                //       label: "",
                                //       child: Shimmer.fromColors(
                                //         baseColor: Colors.grey[300],
                                //         highlightColor: Colors.grey[100],
                                //         child: Container(
                                //           width: 200,
                                //           height: 32,
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //   );
                                // }
                                return CustomInput(
                                  label: "",
                                  child: TextFormField(
                                    initialValue: null != vStore.keyword
                                        ? vStore.keyword
                                        : '',
                                    decoration: InputDecoration(
                                        hintText: "Search",
                                        suffixIcon: Icon(Icons.search)),
                                    onFieldSubmitted: (value) {
                                      print('submit' + value);
                                      vStore.keyword = value;
                                      vStore.getVisitorList(
                                          keyword: value,
                                          keyword_by: vStore.selectedKey.key);
                                    },
                                    //onEditingComplete: ()=>print('edited'),
                                  ),
                                );
                              }),
                              SizedBox(height: 16),
                              Observer(
                                builder: (_) {
                                  if (vStore.isVisitorReady) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Showing ${vStore.dyn_visitor["data"].length} data',
                                          style: kTextWhite,
                                        ),
                                      ),
                                    );
                                  }
                                  return DarkShimmer(
                                    width: 140,
                                    height: 18,
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              //contoh widget header table
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                    gradient: LinearGradient(
                                      colors: [redColor, primaryColor],
                                      begin: FractionalOffset.bottomLeft,
                                      end: FractionalOffset.topRight,
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Name",
                                          style: kTextTitle,
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: DropdownButtonHideUnderline(
                                          child: Observer(builder: (_) {
                                            if (null != vStore.selectedKey) {
                                              if (null == vStore.selectedKey2)
                                                vStore.selectedKey2 =
                                                    vStore.items2[0];
                                              return DropdownButton(
                                                value: vStore.selectedKey2,
                                                isExpanded: true,
                                                iconEnabledColor: Colors.white,
                                                selectedItemBuilder:
                                                    (BuildContext context) {
                                                  return vStore.items2
                                                      .map<Widget>(
                                                          (KeyMap item) {
                                                    return Center(
                                                        widthFactor: 1,
                                                        child: Text(
                                                          vStore.selectedKey
                                                              .value,
                                                          style: kTextTitle,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ));
                                                  }).toList();
                                                },
                                                items: vStore.items2
                                                    .map((KeyMap item) {
                                                  return DropdownMenuItem<
                                                      KeyMap>(
                                                    child: Text(
                                                      item.value,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    value: item,
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    vStore.selectedKey2 = value;
                                                    print(value.key);
                                                    vStore.getVisitorList(
                                                        keyword: vStore.keyword,
                                                        keyword_by: vStore
                                                            .selectedKey.key,
                                                        page: vStore.page,
                                                        order_direction:
                                                            value.key);
                                                  });
                                                },
                                              );
                                            }
                                            return DropdownButton(
                                              value: selectedType2,
                                              isExpanded: true,
                                              items: items.map((String item) {
                                                return DropdownMenuItem<String>(
                                                  // child: Shimmer.fromColors(
                                                  //   baseColor: Colors.grey[300],
                                                  //   highlightColor: Colors.grey[100],
                                                  //   child: Container(
                                                  //     width: 100,
                                                  //     height: 32,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  child: Text(''),
                                                  value: item,
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                            );
                                          }),
                                        ))
                                  ],
                                ),
                              ),
                              Observer(builder: (_) {
                                if (vStore.isVisitorReady) {
                                  Column col = Column(
                                    children: [],
                                  );
                                  if (vStore.dyn_visitor["data"].length == 0) {
                                    return Text(
                                      'No Data',
                                      style: kTextTitleRed,
                                    );
                                  }
                                  for (var v in vStore.dyn_visitor["data"]) {
                                    var colData = TableChild(
                                      backgroundColor: Colors.white10,
                                      borderColor: Colors.white12,
                                      childLeft: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "" + v["name"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "" + v["email"],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      childRight: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 18.0),
                                        child: Text(
                                          (null != vStore.selectedKey &&
                                                  null !=
                                                      v["" +
                                                          vStore
                                                              .selectedKey.key])
                                              ? v["" + vStore.selectedKey.key]
                                              : ""
                                          //vStore.selectedKey2.key
                                          ,
                                          style: TextStyle(color: Colors.white),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      flexLeft: 3,
                                      flexRight: 2,
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            visitorDetailPage,
                                            arguments: v);
                                      },
                                    );
                                    col.children.add(colData);
                                  }
                                  return col;
                                }

                                return TableChild(
                                  backgroundColor: Colors.white10,
                                  borderColor: Colors.grey,
                                  childLeft: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DarkShimmer(
                                        width: 100,
                                        height: 20,
                                      )
                                      // Shimmer.fromColors(
                                      //   baseColor: Colors.grey[850],
                                      //   highlightColor: Colors.grey[800],
                                      //   enabled: true,
                                      //   child: Container(
                                      //     width: 150,
                                      //     height: 20,
                                      //     color: Colors.grey,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  childRight: DarkShimmer(
                                    width: 60,
                                    height: 20,
                                  ),
                                  flexLeft: 3,
                                  flexRight: 2,
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .pushNamed(visitorDetailPage);
                                  },
                                );
                              }),
                              SizedBox(
                                height: 16,
                              ),
                              Observer(builder: (_) {
                                if (vStore.isVisitorReady &&
                                    vStore.hasPagination)
                                  return Pagination(
                                    hasNext: vStore.hasNext,
                                    hasPrev: vStore.hasPrev,
                                    pages: Row(
                                      children: [
                                        Observer(builder: (_) {
                                          var number =
                                              vStore.visitor.meta.currentPage;
                                          var prevNumber = number - 2;
                                          if (prevNumber > 0)
                                            return PaginationNumber(
                                              number: prevNumber,
                                              onTap: () {
                                                print(prevNumber);
                                                vStore.getVisitorList(
                                                    keyword: vStore.keyword,
                                                    keyword_by:
                                                        vStore.selectedKey.key,
                                                    page:
                                                        prevNumber.toString());
                                              },
                                              isSelected: false,
                                            );
                                          else
                                            return Container();
                                        }),
                                        Observer(builder: (_) {
                                          var number =
                                              vStore.visitor.meta.currentPage;
                                          var prevNumber = number - 1;
                                          if (prevNumber > 0)
                                            return PaginationNumber(
                                              number: prevNumber,
                                              onTap: () {
                                                print(prevNumber);
                                                vStore.getVisitorList(
                                                    keyword: vStore.keyword,
                                                    keyword_by:
                                                        vStore.selectedKey.key,
                                                    page:
                                                        prevNumber.toString());
                                              },
                                              isSelected: false,
                                            );
                                          else
                                            return Container();
                                        }),
                                        Observer(builder: (_) {
                                          return PaginationNumber(
                                            number:
                                                vStore.visitor.meta.currentPage,
                                            onTap: () {
                                              print(vStore
                                                  .visitor.meta.currentPage);
                                            },
                                            isSelected: true,
                                          );
                                        }),
                                        Observer(builder: (_) {
                                          var number =
                                              vStore.visitor.meta.currentPage;
                                          var nextNumber = number + 1;
                                          if (nextNumber <=
                                              vStore.visitor.meta.lastPage)
                                            return PaginationNumber(
                                              number: nextNumber,
                                              onTap: () {
                                                print(nextNumber);
                                                vStore.getVisitorList(
                                                    keyword: vStore.keyword,
                                                    keyword_by:
                                                        vStore.selectedKey.key,
                                                    page:
                                                        nextNumber.toString());
                                              },
                                              isSelected: false,
                                            );
                                          else
                                            return Container();
                                        }),
                                        Observer(builder: (_) {
                                          var number =
                                              vStore.visitor.meta.currentPage;
                                          var nextNumber = number + 2;
                                          if (nextNumber <=
                                              vStore.visitor.meta.lastPage)
                                            return PaginationNumber(
                                              number: nextNumber,
                                              onTap: () {
                                                print(nextNumber);
                                                vStore.getVisitorList(
                                                    keyword: vStore.keyword,
                                                    keyword_by:
                                                        vStore.selectedKey.key,
                                                    page:
                                                        nextNumber.toString());
                                              },
                                              isSelected: false,
                                            );
                                          else
                                            return Container();
                                        }),
                                        // PaginationNumber(
                                        //   number: 2,
                                        //   onTap: () {
                                        //     print('2');
                                        //   },
                                        // ),
                                      ],
                                    ),
                                    leftOnTap: () {
                                      print('left');
                                      vStore.doPrevPage();
                                    },
                                    rightOnTap: () {
                                      vStore.doNextPage();
                                    },
                                    numberOnTap: () {
                                      print('number');
                                    },
                                  );
                                return Container();
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
