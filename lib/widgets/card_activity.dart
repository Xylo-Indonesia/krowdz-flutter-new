import 'package:event/services/utilities.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardActivityPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850],
      highlightColor: Colors.grey[800],
      enabled: true,
      child: Container(
        width: double.infinity,
        height: 54,
        color: Colors.grey[800],
      ),
    );
  }
}

class CardActivity extends StatelessWidget {
  final dynamic gamesValue, gamesMaxValue;
  final onTap, isLoading;
  final String gamesName;
  final String imageUrl;

  const CardActivity(
      {Key key,
      this.imageUrl,
      this.gamesValue,
      this.gamesMaxValue,
      this.onTap,
      this.gamesName,
      this.isLoading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: isLoading
          ? CardActivityPlaceholder()
          : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: Colors.white)),
                                    ),
                                    child: Row(
                                      children: [
                                        (null != imageUrl && imageUrl.length > 0
                                            ?
                                            //Container(color: Colors.white,width: 10,height: 10,):
                                            // Image.network(imageUrl,
                                            //     width: 40, height: 40)
                                            Image(
                                                image: AssetImage(imageUrl),
                                              )
                                            : Image(
                                                image: AssetImage(
                                                    'assets/images/games.png'),
                                              )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                gamesName, //'Games',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                Util.numberFormat(
                                                    gamesMaxValue),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Achieve',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white12,
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.white),
                                                        value: gamesValue / 100,
                                                        strokeWidth: 3,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      gamesValue.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: .9),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      '%',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white38,
                                              blurRadius: 2,
                                              spreadRadius: 0.6,
                                              offset: Offset(0, 1))
                                        ]),
                                    child: Icon(Icons.chevron_right,
                                        size: 18, color: Colors.black87),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
