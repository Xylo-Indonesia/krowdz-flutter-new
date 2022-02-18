import 'package:event/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class PrizeItem extends StatelessWidget {
  final String? imageUrl, title, stockString;
  final onTap;

  const PrizeItem({Key? key, this.imageUrl, this.title, this.stockString, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: .9,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color:imageUrl!.length>0?Colors.white: Colors.transparent, borderRadius: BorderRadius.circular(18)),
                  child:
                  imageUrl!.length>0?
                  FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: imageUrl!):Container(),
                ),
              ),
              Text(
                title!,
                style: kTextTitleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                stockString!,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
