import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Widget Loading Apk
Widget wAppLoading(BuildContext context) {
  return Container(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: const Center(
      child: CircularProgressIndicator(),
    ),
  );
}

/// Navigator Push
Future wPushTo(BuildContext context, Widget widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

/// Navigator PushReplace
Future wPushReplaceTo(BuildContext context, Widget widget) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

Future wShowToast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG);
}
