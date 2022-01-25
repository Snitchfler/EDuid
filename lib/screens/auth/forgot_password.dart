// ignore_for_file: camel_case_types

import 'package:firstapk/providers/auth_providers.dart';
import 'package:firstapk/utils/utils.dart';
import 'package:firstapk/widgets/widgets.dart';
import 'package:firstapk/widgets/widgets_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  bool _isLoading = false;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _inputEmail() {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: 'Email', helperText: 'Enter your email'),
      validator: (val) =>
          uValidator(value: val, isEmail: true, isRequired: true),
    );
  }

  Widget _loginSubmit() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('Send'),
        onPressed: () {
          if (!_formKey.currentState!.validate()) return;
          final auth = Provider.of<AuthProvider>(context, listen: false);
          setState(() {
            _isLoading = true;
          });
          auth.resetPassword(
            _email.text,
            context,
          );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _isLoading
          ? wAppLoading(context)
          : Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              resizeToAvoidBottomInset: false,
              body: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      wAuthTitle('Forgot Password ?',
                          'Enter your email and we send you a link to reset your password'),
                      _inputEmail(),
                      const SizedBox(height: 30),
                      _loginSubmit(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
