import 'package:flutter/material.dart';

class TableChild extends StatelessWidget {
  final int? flexLeft, flexRight;
  final childLeft, childRight, backgroundColor, borderColor, onTap, darkMode;

  const TableChild(
      {Key? key,
      this.flexLeft,
      this.flexRight,
      this.childLeft,
      this.childRight,
      this.backgroundColor,
      this.borderColor,
      this.onTap,
      this.darkMode = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(bottom: BorderSide(width: 1, color: borderColor))),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: flexLeft!,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: childLeft,
                        )),
                  ),
                  Expanded(
                    flex: flexRight!,
                    child: childRight,
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: darkMode ? Colors.black38 : Colors.white38,
                              blurRadius: 2,
                              spreadRadius: 0.6,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(Icons.chevron_right,
                        size: 18, color: Colors.black87),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}
