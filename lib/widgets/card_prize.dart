import 'package:event/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardPrize extends StatelessWidget {
  final String? name;
  final int? stock;
  final image, onTap;

  const CardPrize({Key? key, this.name, this.stock, this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  child: Stack(
                    children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: image,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.black54),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(4),
                          child: Text(
                            Util.numberFormat(stock),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                name!,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
