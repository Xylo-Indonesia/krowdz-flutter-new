import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'guest_circle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCard extends StatelessWidget{
  final String eventImageUrl, eventDate, eventMonth, eventTitle, eventLocation, eventId;
  final onTap, onFavoriteTap, scaffoldKey;
  final bool isActive, isAsset, isHomeActive, isToggleVisible;

  const EventCard({Key key, this.eventImageUrl, this.eventDate, this.eventMonth, this.eventTitle, this.eventLocation, this.isActive = true, this.onTap, this.isAsset = true, this.isHomeActive = false, this.eventId, this.scaffoldKey, this.isToggleVisible = true, this.onFavoriteTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: -5, end: 2),
      badgeContent: Text(' '),
      animationType: BadgeAnimationType.fade,
      badgeColor: isHomeActive ? Colors.green : Colors.red,
      showBadge: isActive,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15))
        ),
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      width: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: isAsset ? Image(
                          image: AssetImage(eventImageUrl),
                        ) : FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: eventImageUrl,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [ isActive ? Theme.of(context).primaryColorDark : Colors.white , Colors.transparent], stops: [0.45, 1])
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Text(eventTitle.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: isActive ? Colors.white : Theme.of(context).primaryColorDark),),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 12,
                          color: isActive ? Colors.white : Theme.of(context).primaryColorDark,
                        ),
                        Padding(padding: EdgeInsets.only(left: 2)),
                        Text(eventLocation, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: isActive ? Colors.white : Theme.of(context).primaryColorDark),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: isActive ? Theme.of(context).primaryColorDark : Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                ),
                child: Column(
                  children: <Widget>[
                    Text(eventDate, style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.white : Theme.of(context).primaryColorDark, fontSize: 28.sp),),
                    Text(eventMonth.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.white : Theme.of(context).primaryColorDark))
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onTap,
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 4,
              child: GestureDetector(
                child: Opacity(
                  opacity: isActive ? isToggleVisible ? 1 : 0 : 0,
                  child: GuestCircle(
                    isAdd: true,
                    addIcon: !isHomeActive ? Icons.star_border : Icons.star,
                    bgColor: Theme.of(context).primaryColorDark,
                    addIconColor: Colors.yellowAccent,
                  ),
                ),
                onTap: onFavoriteTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

}