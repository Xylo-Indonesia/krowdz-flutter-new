import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class GuestCircle extends StatelessWidget {
  final isSelected, isAdd, bgColor, addIconColor, addIconBorder, addIcon;
  final image, child;
  final bool isInitialized;

  const GuestCircle(
      {Key? key,
      this.isSelected = false,
      this.image,
      this.isAdd = false,
      this.bgColor,
      this.addIconColor, this.addIconBorder, this.child, this.isInitialized = true, this.addIcon = Icons.add})
      : super(key: key);

  String getInitials(String nameString) {
    if (nameString.isEmpty) return " ";

    List<String> nameArray =
    nameString.replaceAll(new RegExp(r"\s+\b|\b\s"), " ").split(" ");
    String initials = ((nameArray[0])[0] != null ? (nameArray[0])[0] : " ") +
      (nameArray.length == 1 ? "" : (nameArray[nameArray.length - 1])[0]);
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    if (!isAdd) {
      return Stack(
        children: <Widget>[
          image != null ?
          CircleAvatar(
            backgroundImage: AssetImage(image),
            backgroundColor: bgColor,
            child: Text(isInitialized ? getInitials(child) : child, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          ) :
          CircleAvatar(
            backgroundColor: bgColor,
            child: Text(isInitialized ? getInitials(child) : child, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          isSelected
              ? CircleAvatar(
                  backgroundColor: Colors.green.withOpacity(0.8),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ))
              : CircleAvatar(
                  backgroundColor: Colors.transparent,
                )
        ],
      );
    } else {
      return Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: addIconBorder
        ),
        child: CircleAvatar(
            child: Icon(addIcon, color: addIconColor),
            backgroundColor: bgColor,
        ),
      );
    }
  }
}
