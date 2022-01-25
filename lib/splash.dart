import 'package:firstapk/screens/auth/login.dart';
import 'package:firstapk/screens/home/home.dart';
import 'package:firstapk/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _checkUserSementara(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wAppLoading(context),
    );
  }

  void _checkUserSementara(bool user) async {
    await Future.delayed(const Duration(seconds: 2));

    // Navigator
    // Push & Push Replacement
    wPushReplaceTo(context, user ? const Home() : const Login());
  }
}
