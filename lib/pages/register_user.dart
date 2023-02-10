import 'package:flutter/material.dart';
import 'package:surakshya/main.dart';
import '../components/custom_textfield.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';

class RegisterUser extends StatefulWidget {
  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool isPasswordShown = true;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();

  _onSubmit() {
    _formKey.currentState!.save();
    print(_formData['number']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Container(
                child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Image.asset('assets/images/woman.jpg', height: 250),
            Text(
              "Register as User",
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
            CustomTextField(
              hintText: "Name",
              prefix: Icon(Icons.woman),
              textInputAction: TextInputAction.next,
              onsave: (name) {
                _formData['name'] = name ?? "";
              },
              validate: (name) {
                if (name!.isEmpty || name.length < 2) {
                  return 'Enter a correct name';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            CustomTextField(
              hintText: "Phone number",
              textInputAction: TextInputAction.next,
              keyboardtype: TextInputType.phone,
              prefix: Icon(Icons.phone),
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
              onsave: (email) {
                _formData['email'] = email ?? "";
              },
            ),
            SizedBox(height: 18),
            CustomTextField(
              hintText: "Guardian's Number",
              prefix: Icon(Icons.phone),
              textInputAction: TextInputAction.next,
              keyboardtype: TextInputType.number,
              onsave: (gnumber) {
                _formData['gnumber'] = gnumber ?? "";
              },
              validate: (gnumber) {
                if (gnumber!.isEmpty || gnumber.length < 10) {
                  return "Enter correct number";
                }
              },
            ),
            SizedBox(height: 18),
            CustomTextField(
              hintText: "Guardian's email",
              prefix: Icon(Icons.key),
              textInputAction: TextInputAction.next,
              keyboardtype: TextInputType.emailAddress,
              validate: (gemail) {
                if (gemail!.isEmpty ||
                    gemail.length < 3 ||
                    !gemail.contains("@")) {
                  return 'Enter correct email.';
                }
                return null;
              },
              onsave: (gemail) {
                _formData['gemail'] = gemail ?? "";
              },
            ),
            SizedBox(height: 18),
            CustomTextField(
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
                onsave: (password) {
                  _formData['password'] = password ?? "";
                }),
            SizedBox(height: 18),
            PrimaryButton(
                btnTitle: "REGISTER",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onSubmit();
                  }
                }),
            SizedBox(height: 5),
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
