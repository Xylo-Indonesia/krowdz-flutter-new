import 'package:event/model/keymap.dart';
import 'package:event/services/consts.dart';
import 'package:event/services/utilities.dart';
import 'package:event/stores/prize_list_store.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_dialog.dart';
import 'package:event/widgets/custom_dialog_prize.dart';
import 'package:event/widgets/custom_dropdown.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:event/widgets/custom_input.dart';
import 'package:event/widgets/prize_item.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:transparent_image/transparent_image.dart';

class PrizeList extends StatefulWidget {
  @override
  _PrizeListState createState() => _PrizeListState();
}

class _PrizeListState extends State<PrizeList> {
  PrizeListStore store = PrizeListStore();
  String selectedType = 'Testing';

  _PrizeListState() {
    store.getActivity();
    store.getDashboardPrize();
  }

  @override
  Widget build(BuildContext context) {
    return BlackTheme(
      darkMode: true,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16),
                  child: CustomHeader(
                    darkMode: true,
                    onBack: () {
                      Navigator.pop(context);
                    },
                    title: "Prize List",
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          CustomInput(
                            label: '',
                            child: Observer(builder: (_) {
                              List<KeyMap> activityList =
                                  []; //KeyMap('value', '123'), KeyMap('value', 'qwe'), KeyMap('value', 'asd')
                              if (store.ac != null && store.ac.status == true) {
                                activityList.add(KeyMap('value', 'All'));
                                for (var item in store.ac.data) {
                                  activityList.add(KeyMap('value', item.name));
                                  print("activity " + item.name);
                                }
                                return CustomDropdown(
                                  itemList: activityList,
                                  onClick: (value) {
                                    KeyMap keymap = value;
                                    print('selected: ' + keymap.value);
                                    String tmp_activity = '';
                                    tmp_activity = keymap.value == 'All'
                                        ? ''
                                        : keymap.value;
                                    store.activity = tmp_activity;
                                    store.getDashboardPrize();
                                  },
                                );
                              }

                              return CustomDropdown(
                                itemList: [],
                                onClick: (value) {
                                  print('selected: ' + value);
                                },
                              );
                            }),
                          ),
                          CustomInput(
                            label: "",
                            child: TextFormField(
                              initialValue: '',
                              decoration: InputDecoration(
                                  hintText: "Search",
                                  suffixIcon: Icon(Icons.search)),
                              onFieldSubmitted: (value) {
                                print('submit' + value);
                                store.keyword = value;
                                store.getDashboardPrize();
                              },
                              //onEditingComplete: ()=>print('edited'),
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Observer(builder: (_) {
                            var col = Column(
                              children: [],
                            );
                            var x = 0;
                            var row = Row();

                            if (store.rewards != null &&
                                true == store.rewards.status) {
                              for (var pr in store.rewards.data) {
                                if (x % 3 == 0) {
                                  row = Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [],
                                  );
                                }
                                var pi = PrizeItem(
                                  imageUrl: pr.image != null
                                      ? pr.image
                                      : 'https://dev.bounche.com/krowdz/app/gift.jpg',
                                  title: '' + pr.name,
                                  stockString: pr.remainingQuotas.toString() +
                                      '/' +
                                      pr.quota.toString(),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierColor: Colors.transparent,
                                        builder: (BuildContext context) {
                                          List listActivity = [];

                                          for (var ac in pr.activities) {
                                            var acItem = {
                                              'name': ac.name,
                                              'image':
                                                  Util.getActivityIcon(ac.icon)
                                            };
                                            listActivity.add(acItem);
                                          }

                                          return CustomDialogPrize(
                                            availableList: listActivity,
                                            prizeName: '' + pr.name,
                                            imageUrl: pr.image != null
                                                ? pr.image
                                                : 'https://dev.bounche.com/krowdz/app/gift.jpg',
                                            currentStock: '' +
                                                pr.remainingQuotas.toString(),
                                            maxStock: '' + pr.quota.toString(),
                                          );
                                        });
                                  },
                                );
                                row.children.add(pi);
                                if (x % 3 == 2 ||
                                    x + 1 == store.rewards.data.length) {
                                  if (row.children.length < 3) {
                                    //belum 3, harus digenapin dengan dummy data
                                    if (row.children.length == 1) {
                                      row.children.add(PrizeItem(
                                        imageUrl: '',
                                        title: '',
                                        stockString: '',
                                      ));
                                      row.children.add(PrizeItem(
                                        imageUrl: '',
                                        title: '',
                                        stockString: '',
                                      ));
                                    }
                                    if (row.children.length == 2) {
                                      row.children.add(PrizeItem(
                                        imageUrl: '',
                                        title: '',
                                        stockString: '',
                                      ));
                                    }
                                  }
                                  col.children.add(row);
                                  col.children.add(SizedBox(
                                    height: 16,
                                  ));
                                  //break;
                                }
                                x++;
                                print('x' + x.toString());
                              }
                            }

                            return col;
                          }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
