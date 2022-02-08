import 'package:flutter/material.dart';

class VisitorDetailActivity extends StatelessWidget {
  final image, onTap, title;

  const VisitorDetailActivity({Key key, this.image, this.onTap, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: [
              Image(
                image: AssetImage(image),
                width: 40,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(title),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            spreadRadius: 0.6,
                            offset: Offset(0, 1))
                      ]),
                  child:
                      Icon(Icons.chevron_right, size: 18, color: Colors.white),
                ),
              ),
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
