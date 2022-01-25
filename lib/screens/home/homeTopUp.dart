// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:firstapk/datass/datax.dart';
import 'package:firstapk/providers/auth_providers.dart';
import 'package:firstapk/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class homeTopUp extends StatefulWidget {
  const homeTopUp({Key? key}) : super(key: key);

  @override
  _homeTopUpState createState() => _homeTopUpState();
}

class _homeTopUpState extends State<homeTopUp> {
  bool _isLoading = false;
  bool _isSended = false;
  final TextEditingController _inputAmount = TextEditingController();

  Widget _cashSended() {
    return Column(
      children: <Widget>[
        TextButton(
            onPressed: () async {
              dTopUp.moneyTopUp = _inputAmount.text;
              Home.enteredValue.value = _inputAmount.text;

              setState(() {
                _isLoading = true;
              });

              final auth = Provider.of<AuthProvider>(context, listen: false);
              await auth.resendEmailVerification();
              setState(() {
                _isLoading = false;
                _isSended = true;
              });
            },
            child: Text(_isLoading ? 'Sending' : 'Top Up'))
      ],
    );
  }

  Widget _inputCash() {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 50, 50, 50),
      child: TextField(
        controller: _inputAmount,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(hintText: '100.000'),
      ),
    );
  }

  Widget _SendCash() {
    return const Text(
      'Succes',
      style: TextStyle(color: Colors.green),
    );
  }

  Widget _bottomWidget() {
    return _isSended ? _SendCash() : _cashSended();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20))),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.drag_handle),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    MdiIcons.cashPlus,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Recharge Your Money',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('How much ?', textAlign: TextAlign.center),
                  const SizedBox(height: 30),
                  _inputCash(),
                  _bottomWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
