// ignore_for_file: file_names, camel_case_types, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapk/model/user_model.dart';
import 'package:firstapk/screens/auth/login.dart';
import 'package:flutter/material.dart';

class HomeWithSidebar extends StatelessWidget {
  const HomeWithSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeWithSidebar(),
    );
  }
}

class homeWithSidebar extends StatefulWidget {
  const homeWithSidebar({Key? key}) : super(key: key);

  @override
  _homeWithSidebarState createState() => _homeWithSidebarState();
}

// ignore: camel_case_types
class _homeWithSidebarState extends State<homeWithSidebar> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMapMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        // ignore: use_full_hex_values_for_flutter_colors
        backgroundColor: const Color(0xffff1f3f6),
        body: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(60)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xfff1f3f6),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/guest.png'),
                                      fit: BoxFit.contain)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${loggedInUser.username}',
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '${loggedInUser.email}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sidebarTitle('Home', true),
                      sidebarTitle('Profile', false),
                      sidebarTitle('Accounts', false),
                      sidebarTitle('Transactions', false),
                      sidebarTitle('Stats', false),
                      sidebarTitle('Settings', false),
                      sidebarTitle('Help', false),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => logout(context),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.power_settings_new,
                          size: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Beta Version Masih kek apk tolol',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row sidebarTitle(String name, bool isSelected) {
    return Row(
      children: [
        (isSelected)
            ? Container(
                width: 5,
                height: 60,
                color: const Color(0xff000000),
              )
            : const SizedBox(
                width: 5,
                height: 60,
              ),
        const SizedBox(
          width: 10,
          height: 60,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400,
          ),
        )
      ],
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }
}
