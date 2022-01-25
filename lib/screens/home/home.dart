import 'package:firstapk/datass/datax.dart';
import 'package:firstapk/screens/home/homeSidebar.dart';
import 'package:firstapk/screens/home/homeTopUp.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static ValueNotifier<String> enteredValue = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  MdiIcons.walletTravel,
                  color: Colors.black,
                  size: 30,
                ),
              );
            }),
            title: const Text(
              'e-Duid',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        drawer: const homeWithSidebar(),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ), // rooow
              const Text(
                'Account Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rp. 0${dTopUp.TopUp} ',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Current Balance',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black12,
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return const homeTopUp();
                                });
                          },
                          child: const Icon(
                            MdiIcons.plus,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '  Send Money',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Icon(MdiIcons.send),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black12,
                        ),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.add,
                            size: 40,
                          ),
                          onTap: () {},
                        )),
                    avatarWidget('avatar1', 'User 1'),
                    avatarWidget('avatar2', 'User 2'),
                    avatarWidget('avatar3', 'User 3'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '  Services',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Icon(Icons.dialpad),
                  )
                ],
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  children: [
                    serviceWidget('sendMoney', 'Send\nMoney'),
                    serviceWidget('receiveMoney', 'Receive\nMoney'),
                    serviceWidget('phone', 'Mobile\nTop Up'),
                    serviceWidget('electricity', 'Electricity\nBill'),
                    serviceWidget('tag', 'Cashback\nOffer'),
                    serviceWidget('movie', 'Movie\nTicket'),
                    serviceWidget('flight', 'Flight\nTicket'),
                    serviceWidget('more', 'More\n'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black12),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/$img.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 150,
      width: 120,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.black12,
      ),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircleAvatar(
              radius: 36,
              child: Icon(
                MdiIcons.faceMan,
                color: Colors.black,
                size: 40,
              ),
              backgroundColor: Colors.black12,
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
