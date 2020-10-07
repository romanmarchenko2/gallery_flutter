import 'package:flutter/material.dart';
import 'package:flutter_gallery/domain/user.dart';
import 'package:flutter_gallery/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AutorizationPage extends StatefulWidget {
  @override
  _AutorizationPageState createState() => _AutorizationPageState();
}

class _AutorizationPageState extends State<AutorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool _showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
          padding: EdgeInsets.only(top: 60),
          child: Align(
            child: Text(
              "Gallery",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ));
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obsecure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obsecure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 20, color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )),
        ),
      );
    }

    Widget _button(String label, void func()) {
      return RaisedButton(
        highlightColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        color: Colors.white,
        child: Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20)),
        onPressed: () {
          func();
          FocusScope.of(context).unfocus();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 30),
              child:
                  _input(Icon(Icons.email), "Email", _emailController, false),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: _input(
                  Icon(Icons.lock), "Password", _passwordController, true),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    Future _errorMessage(String label) {
      return Fluttertoast.showToast(
          msg: label,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 20.0);
    }

    void _loginButonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      if (_email.isEmpty || _password.isEmpty) return;
      GalleryUser user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());

      if (user == null) {
        _errorMessage("Incorrect email or password");
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      if (_email.isEmpty || _password.isEmpty) return;
      GalleryUser user = await _authService.registerWithEmailAndPassword(
          _email.trim(), _password.trim());

      if (user == null) {
        _errorMessage("Incorrect email or password");
      } else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Widget _showForm(
        String buttonLabel, String subtitle, bool showLogin, void action()) {
      return Expanded(
          child: Column(children: <Widget>[
        _form(buttonLabel, action),
        Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              child: Text(subtitle,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
              onTap: () {
                setState(() {
                  FocusScope.of(context).unfocus();
                  _showLogin = showLogin;
                });
              },
            ))
      ]));
    }

    return Scaffold(
        backgroundColor: Colors.black87,
        body: Column(children: <Widget>[
          _logo(),
          (_showLogin
              ? _showForm("Login", "Not registered? Register!", false,
                  _loginButonAction)
              : _showForm("Register", "Already registered? Log in!", true,
                  _registerButonAction))
        ]));
  }
}
