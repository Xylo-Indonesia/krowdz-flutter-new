import 'package:flutter/material.dart';

class TopOverflowCard extends StatefulWidget{
  final child;

  const TopOverflowCard({Key? key, this.child}) : super(key: key);

  @override
  _StateTopOverflowCard createState() {
    return _StateTopOverflowCard();
  }
}

class _StateTopOverflowCard extends State<TopOverflowCard>{
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              widget.child
            ],
          )),
      ),
    );
  }
}