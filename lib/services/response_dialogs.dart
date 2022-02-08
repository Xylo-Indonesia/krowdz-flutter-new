import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponseDialog {
  static AlertDialog showConfirmDialog(
      BuildContext context, String name, String email, dynamic onPressed, onPressedCancel) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/success.png')),
          Padding(padding: EdgeInsets.only(top: 12)),
          Text(
            "This code are on your guest list.",
          ),
          Text(
            "Proceed to invite guest?",
          ),
          Padding(padding: EdgeInsets.only(top: 24)),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          Text(
            email
          ),
          Padding(padding: EdgeInsets.only(top: 24)),
          SizedBox(
            width: double.infinity,
            child: FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: onPressed == null ? () {} : onPressed,
                child: Text("CONTINUE")),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
                color: Colors.white,
                textColor: Theme.of(context).primaryColor,
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                onPressed: onPressedCancel == null ? () {
                  Navigator.pop(context);
                } : onPressedCancel,
                child: Text("CANCEL")),
          ),
        ],
      ),
    );
  }

  static AlertDialog showResponseDialog(
      BuildContext context, bool isError, String message, dynamic onPressed) {
    if (isError) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/failed.png')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'FAILED',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
            ),
            Center(
              child: Text(
                message.isEmpty ? "" : message,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 12)),
            SizedBox(
              width: double.infinity,
              child: OutlineButton(
                  color: Colors.white,
                  textColor: Theme.of(context).primaryColor,
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  onPressed: onPressed == null ? () {} : onPressed,
                  child: Text("DISMISS")),
            )
          ],
        ),
      );
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/success.png')),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'SUCCESS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
            ),
          ),
          Text(
            message.isEmpty ? "" : message,
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
                color: Colors.white,
                textColor: Theme.of(context).primaryColor,
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                onPressed: onPressed == null ? () {} : onPressed,
                child: Text("CONTINUE")),
          )
        ],
      ),
    );
  }

  static AlertDialog showMessageDialog(BuildContext context, String message, dynamic onPressed){
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text("CONFIRM")),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              color: Colors.white,
              textColor: Theme.of(context).primaryColor,
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("CANCEL")),
          )
        ],
      ),
    );
  }

  static AlertDialog showVersionDialog(BuildContext context, String message, dynamic onPressed){
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: onPressed,
                child: Text("CONFIRM")),
          ),

        ],
      ),
    );
  }
}
