import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:surakshya/main.dart';
import '../components/custom_textfield.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';
import '../config.dart';

class RegisterUser extends StatefulWidget {
  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool isPasswordShown = true;
  //textfield controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _selectedVal = "user";

  //list in dropdown
  List<String> role = ['user', 'parent'];

  _MyFormState() {
    _selectedVal = role[0];
  }

  //function to register user
  void registerUser() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        _selectedVal == _selectedVal) {
      var regBody = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": _selectedVal
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse['status']);
      if (jsonResponse['status']) {
        CircularProgressIndicator();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginOptions()));
        Fluttertoast.showToast(msg: "User registered successfully");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
            child: Container(
                child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Image.asset('assets/images/woman.jpg', height: 250),
            Text(
              "Register Here",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              "Please enter the details to register",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
            ),
            SizedBox(height: 18),
            Container(
              width: 300,
              child: Row(children: [
                Text(
                  "Please specify user type:         ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.green),
                ),
                DropdownButton(
                    value: _selectedVal,
                    items: role
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedVal = val as String;
                      });
                    }),
              ]),
            ),
            SizedBox(height: 15),
            CustomTextField(
              controller: nameController,
              hintText: "Name",
              prefix: Icon(Icons.woman),
              textInputAction: TextInputAction.next,
              validate: (name) {
                if (name!.isEmpty || name.length < 2) {
                  return 'Enter a correct name';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              textInputAction: TextInputAction.next,
              keyboardtype: TextInputType.emailAddress,
              prefix: Icon(Icons.mail),
              validate: (email) {
                if (email!.isEmpty ||
                    email.length < 3 ||
                    !email.contains("@")) {
                  return 'Enter correct email.';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              isPassword: isPasswordShown,
              prefix: Icon(Icons.key),
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
            ),
            SizedBox(height: 18),
            PrimaryButton(btnTitle: "REGISTER", onPressed: registerUser),
            SizedBox(height: 25),
            Text(
              "Already have an account?",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginOptions()));
                },
                child: Text(
                  "Log In to existing account",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.green),
                )),
          ]),
        ))),
      ),
    );
  }
}
