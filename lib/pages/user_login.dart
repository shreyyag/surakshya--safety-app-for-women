import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surakshya/components/custom_textfield.dart';
import 'package:surakshya/components/secondary_button.dart';
import 'package:surakshya/config.dart';
import 'package:surakshya/pages/register_user.dart';
import 'package:surakshya/pages/splash_screen.dart';
import 'package:surakshya/parent/homeParent.dart';
import '../child/bottom_nav.dart';
import '../components/primary_button.dart';
import 'package:http/http.dart' as http;

class LoginOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginOptionsState();
}

class LoginOptionsState extends State<LoginOptions> {
  //defining controllers
  bool isPasswordShown = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      //Saving token in shared preference
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        var userRole = jsonResponse['role'];

        prefs.setString("token", myToken);
        prefs.setString("role", userRole);
        Fluttertoast.showToast(msg: "Loging in");

        if (userRole == "user") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNav(token: myToken)));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => BottomNav()));
        } else if (userRole == "parent") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ParentHomePage()));
        } else
          () {};
      } else {
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    }
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Image.asset('assets/images/woman.jpg', height: 280),
                SizedBox(height: 40),
                Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  "Please proceed with your LOGIN",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
                ),
                SizedBox(height: 18),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  textInputAction: TextInputAction.next,
                  keyboardtype: TextInputType.emailAddress,
                  prefix: Icon(Icons.woman),
                  validate: (number) {
                    if (number!.isEmpty || number.length < 10) {
                      return 'Enter correct email!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  prefix: Icon(Icons.zoom_in_rounded),
                  isPassword: isPasswordShown,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordShown = !isPasswordShown;
                        });
                      },
                      icon: isPasswordShown
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  validate: (password) {
                    //password!.isEmpty || password.length < 7
                    if (password!.isEmpty) {
                      return 'Enter correct password!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  btnTitle: "LOGIN",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      loginUser();
                    }
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                ),
                SizedBox(height: 40),
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterUser()));
                    },
                    child: Text(
                      "Register Here",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
