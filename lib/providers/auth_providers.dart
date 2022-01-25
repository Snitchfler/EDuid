// ignore_for_file: avoid_print

import 'package:firstapk/screens/auth/login.dart';
import 'package:firstapk/screens/auth/verif_email.dart';
import 'package:firstapk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider with ChangeNotifier {
  /// Login Email & Password
  // void loginwithemail(
  //     @required BuildContext context, String email, String password) async {
  //   if (email == 'demo@gmail.com' && password == 'admin123') {
  //     await Future.delayed(Duration(seconds: 5));

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => Home()),
  //     );
  //     wPushReplaceTo(context, Home());
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: 'Email or Account not Found',
  //         backgroundColor: Colors.black54,
  //         textColor: Colors.white,
  //         toastLength: Toast.LENGTH_LONG);
  //   }
  // }

  void resetPassword(String email, BuildContext context) async {
    if (email.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      wShowToast('Email Sended ! Please check your email to reset password');
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: 'Email not found',
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  void registerWithEmail(String email, String name, String password,
      String passwordconfirm, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    wPushReplaceTo(context, const Login());

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return const VerifEmail();
        });
  }

  Future<void> resendEmailVerification() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
