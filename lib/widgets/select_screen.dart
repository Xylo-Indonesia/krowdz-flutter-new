import 'package:event/model/keymap.dart';
import 'package:event/widgets/black_theme.dart';
import 'package:event/widgets/custom_header.dart';
import 'package:flutter/material.dart';

class SelectItem extends StatelessWidget {
  final Function? onTap;
  final String? text;

  const SelectItem({Key? key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
        ),
        child: Text(text!),
      ),
    );
  }
}

class SelectScreen extends StatelessWidget {
  final List<KeyMap>? arguments;

  const SelectScreen({Key? key, this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> selectList = [];

    for (var i = 0; i < arguments!.length; i++) {
      selectList.add(SelectItem(
          onTap: () {
            //returns the selected value back to async function from previous screen
            //Navigator.pop(context, arguments[i].value);
            Navigator.pop(context, arguments![i]);
          },
          text: arguments![i].value));
    }

    return BlackTheme(
      darkMode: false,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16),
                    child: CustomHeader(
                      darkMode: false,
                      title: 'Filter',
                      icon: 'assets/images/close.png',
                      onBack: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.grey[400]!, width: 1)),
                    ),
                  ),
                  Column(
                    children: [],
                  ),
                  Column(
                    children: selectList,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
