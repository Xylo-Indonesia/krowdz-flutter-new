import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatefulWidget {
  final childLeft, childRight, isGradient, backgroundColor;
  final int flexLeft, flexRight;

  const TableHeader(
      {Key key,
      this.childLeft,
      this.childRight,
      this.flexLeft,
      this.flexRight,
      this.isGradient = false,
      this.backgroundColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TableHeaderState();
  }
}

class TableHeaderState extends State<TableHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: !widget.isGradient ? widget.backgroundColor : primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          gradient: widget.isGradient
              ? LinearGradient(
                  colors: widget.backgroundColor,
                  begin: FractionalOffset.bottomLeft,
                  end: FractionalOffset.topRight,
                )
              : null),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(flex: widget.flexLeft, child: widget.childLeft),
          Expanded(
            flex: widget.flexRight,
            child: widget.childRight,
          )
        ],
      ),
    );
  }
}
