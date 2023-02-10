import 'package:flutter/material.dart';
import 'package:surakshya/components/custom_textfield.dart';
import 'package:surakshya/components/secondary_button.dart';
import 'package:surakshya/pages/register_user.dart';
import 'package:surakshya/pages/splash_screen.dart';

import 'child/bottom_nav.dart';
import 'components/primary_button.dart';
import 'child/bottom_screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(),
    );
  }
}

class LoginOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginOptionsState();
}

class LoginOptionsState extends State<LoginOptions> {
  //defining controllers
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  _onSubmit() {
    _formKey.currentState!.save();
    print(_formData['number']);
    print(_formData['password']);
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
                  "USER LOGIN",
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
                  hintText: "Number",
                  textInputAction: TextInputAction.next,
                  keyboardtype: TextInputType.number,
                  prefix: Icon(Icons.woman),
                  onsave: (number) {
                    _formData['number'] = number ?? "";
                  },
                  validate: (number) {
                    if (number!.isEmpty || number.length < 10) {
                      return 'Enter correct number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
                CustomTextField(
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
                    if (password!.isEmpty || password.length < 7) {
                      return 'Enter correct password.';
                    }
                    return null;
                  },
                  onsave: (password) {
                    _formData['password'] = password ?? "";
                  },
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  btnTitle: "LOGIN",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                  // onPressed: () {
                  //   if (_formKey.currentState!.validate()) {
                  //     _onSubmit();
                  //   }
                  // }
                ),
                SizedBox(height: 5),
                SecondaryButton(title: "Forgot Password", onPressed: () {}),
                SizedBox(height: 30),
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
