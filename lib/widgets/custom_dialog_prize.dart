import 'dart:ui';
import 'package:event/widgets/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomDialogPrize extends StatefulWidget {
  final List availableList;
  final String prizeName, currentStock, maxStock, imageUrl;

  const CustomDialogPrize(
      {Key key,
      this.imageUrl,
      this.availableList,
      this.prizeName,
      this.currentStock,
      this.maxStock})
      : super(key: key);
  @override
  _CustomDialogPrizeState createState() => _CustomDialogPrizeState();
}

class Constants {
  Constants._();

  static const double padding = 10;
  static const double avatarRadius = 45;
}

class _CustomDialogPrizeState extends State<CustomDialogPrize> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 4),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        ));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Constants.padding),
            ),
            child: Container(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(color: darkerBackground),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: '' + widget.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.prizeName,
                                style: kTextTitleLarge,
                              ),
                              Text(
                                widget.currentStock + '/' + widget.maxStock,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Available for:",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Row(
                            children: widget.availableList
                                .map((e) => Container(
                                      margin: EdgeInsets.only(right: 12),
                                      child: Column(
                                        children: [
                                          (e['image'] != null
                                              ? Image(
                                                  image: AssetImage(e['image']),
                                                  width: 40,
                                                  fit: BoxFit.fill)
                                              : Image(
                                                  image: AssetImage(
                                                      'assets/images/games-dark.png'),
                                                  width: 40,
                                                  fit: BoxFit.fill)),
                                          FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: e['image'],
                                              width: 40,
                                              fit: BoxFit.fill),
                                          Text(
                                            e['name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
