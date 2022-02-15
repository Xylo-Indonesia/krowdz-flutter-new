import 'package:event/model/keymap.dart';
import 'package:event/services/consts.dart';
import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<KeyMap> itemList;
  final Function onClick;
  final KeyMap widgetSelectedType;

  const CustomDropdown(
      {Key key, this.itemList, this.onClick, this.widgetSelectedType})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  KeyMap selectedType = KeyMap('value', 'Select...');

  @override
  Widget build(BuildContext context) {
    if (widget.widgetSelectedType != null) {
      selectedType = widget.widgetSelectedType;
    }
    return GestureDetector(
      onTap: () async {
        //await the Navigator, expecting to recieve a String to be shown here
        final selected = await Navigator.pushNamed(context, selectScreenRoute,
            arguments: widget.itemList);
        //refresh the screen to show the selected value
        setState(() {
          if (selected != null) {
            selectedType = selected;
          }
        });

        widget.onClick(selectedType);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: darkBackground, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedType.value,
              style: TextStyle(fontSize: 16),
            ),
            Image(
              image: AssetImage('assets/images/select.png'),
              width: 10,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
    );
  }
}
