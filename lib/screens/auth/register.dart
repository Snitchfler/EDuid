// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapk/model/user_model.dart';
import 'package:firstapk/providers/auth_providers.dart';
import 'package:firstapk/screens/auth/login.dart';
import 'package:firstapk/utils/utils.dart';
import 'package:firstapk/widgets/widgets.dart';
import 'package:firstapk/widgets/widgets_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordconfirm = TextEditingController();
  final bool _obscureText = true;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  Widget _inputName() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      controller: _name,
      decoration: const InputDecoration(
          hintText: 'Name', helperText: 'Enter Full Name'),
      validator: (val) => uValidator(
        value: val,
        isRequired: true,
        minLength: 3,
      ),
    );
  }

  Widget _inputEmail() {
    return TextFormField(
      controller: _email,
      decoration:
          const InputDecoration(hintText: 'Email', helperText: 'Enter Email'),
      validator: (val) =>
          uValidator(value: val, isEmail: true, isRequired: true),
    );
  }

  Widget _inputPassword() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _password,
            obscureText: _obscureText,
            decoration: const InputDecoration(
              hintText: '**********',
              helperText: 'Enter Password',
            ),
            validator: (val) =>
                uValidator(value: val, isRequired: true, minLength: 6),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: _passwordconfirm,
            obscureText: _obscureText,
            decoration: const InputDecoration(
                hintText: '**********', helperText: 'Confirm Password'),
            validator: (val) => uValidator(
                value: val,
                isRequired: true,
                minLength: 6,
                match: _password.text),
          ),
        )
      ],
    );
  }

  Widget _RegisterSubmit() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        child: const Text('Register'),
        onPressed: () {
          signUp(_email.text, _password.text);
        },
      ),
    );
  }

  Widget _googleSignIn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black)),
          icon: const Icon(
            MdiIcons.google,
            size: 20,
          ),
          label: const Text('Google')),
    );
  }

  Widget _accountLogin() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Already have an account?'),
          GestureDetector(
            onTap: () => wPushReplaceTo(context, const Login()),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: const Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
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
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black)),
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        wAuthTitle('Register', 'Fill the form to register'),
                        _inputName(),
                        _inputEmail(),
                        _inputPassword(),
                        const SizedBox(height: 30),
                        _RegisterSubmit(),
                        wTextDivider(),
                        _googleSignIn(),
                        _accountLogin(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.messeage);
      });
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthProvider>(context, listen: false);
      auth.registerWithEmail(_email.text, _name.text, _password.text,
          _passwordconfirm.text, context);
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.username = _name.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Accoun created Succesfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}
