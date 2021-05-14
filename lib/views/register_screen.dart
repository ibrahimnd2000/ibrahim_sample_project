import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ibrahim_sample_project/model/user.dart' as UserModel;
import 'package:ibrahim_sample_project/services/auth_service.dart';
import 'package:ibrahim_sample_project/services/db_service.dart';
import 'package:ibrahim_sample_project/views/widgets/sample_app_button.dart';
import 'package:ibrahim_sample_project/views/widgets/sample_app_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  Function switchAuthPage;
  RegisterScreen({Key key, this.switchAuthPage}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name, _email, _pass;
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  bool validateForm(String name, String email, String pass) {
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        pass.isNotEmpty &&
        pass.length >= 5) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEE1ED),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign up with email",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF7883B4),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => getImage(),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF7883B4),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SampleAppTextField(
                    hintText: "Name",
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Name is empty';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _name = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SampleAppTextField(
                    hintText: "Email",
                    validator: (text) {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(text) || text == null) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _email = val;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SampleAppTextField(
                    hintText: "Password",
                    isPassword: true,
                    showPass: false,
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length <= 5) {
                        return 'Please enter a strong password.';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _pass = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SampleAppButton(
                    text: "Sign Up",
                    action: () async {
                      if (_formKey.currentState.validate()) {
                        String result = await context
                            .read<AuthService>()
                            .signUp(email: _email, password: _pass);
                        if (result != 'Signed up') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                            ),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          UserModel.User user =
                              UserModel.User("", _name, _email);
                          context.read<DBService>().addUser(user);
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color(0xFF808CBA),
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: widget.switchAuthPage,
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 50,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF394A93),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
