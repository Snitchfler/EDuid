import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapk/screens/auth/register.dart';
import 'package:firstapk/screens/home/home.dart';
import 'package:firstapk/utils/utils.dart';
import 'package:firstapk/widgets/widgets.dart';
import 'package:firstapk/widgets/widgets_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  final bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _fAuth = FirebaseAuth.instance;
  Widget _inputEmail() {
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: 'Email'),
      validator: (val) => uValidator(
        value: val,
        isRequired: true,
        isEmail: true,
      ),
    );
  }

  Widget _inputPassword() {
    return Stack(
      children: <Widget>[
        TextFormField(
          controller: _password,
          obscureText: _obscureText,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          validator: (val) => uValidator(
            value: val,
            isRequired: true,
            minLength: 6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            child: const Text('Forgot Password ?'),
          ),
        ),
        onTap: () => wPushTo(context, const forgotPassword()));
  }

  Widget _loginSubmit() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () {
          _loginSementara(_email.text, _password.text);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
      ),
    );
  }

  Widget _googleSignIn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black)),
          onPressed: () {},
          icon: const Icon(
            MdiIcons.google,
            size: 20,
          ),
          label: const Text('Google')),
    );
  }

  Widget _accountRegister() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Dont have an account yet ?'),
          GestureDetector(
            onTap: () => wPushTo(context, const Register()),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: const Text(
                'Register',
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
              resizeToAvoidBottomInset: false,
              body: Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      wAuthTitle('Login', 'Enter your email & password'),
                      _inputEmail(),
                      _inputPassword(),
                      _forgotPassword(),
                      _loginSubmit(),
                      wTextDivider(),
                      _googleSignIn(),
                      _accountRegister(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _loginSementara(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _fAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => {
              Fluttertoast.showToast(msg: "Login Succesfull"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home())),
            },
          );
    } else {
      Fluttertoast.showToast(
          msg: 'Email or Account not Found',
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _fAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => {
              Fluttertoast.showToast(msg: "Login Succesfull"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home())),
            },
          );
    }
  }
}
