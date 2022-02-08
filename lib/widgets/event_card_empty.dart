import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:event/services/consts.dart';

class EventCardEmpty extends StatelessWidget{
  final child;
  final onTap;

  const EventCardEmpty({Key key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: double.infinity,
              child: child
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

}