import 'package:flutter/material.dart';
import 'package:ibrahim_sample_project/services/auth_service.dart';
import 'package:ibrahim_sample_project/views/widgets/sample_app_button.dart';
import 'package:ibrahim_sample_project/views/widgets/sample_app_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  Function switchAuthPage;
  LoginScreen({Key key, this.switchAuthPage}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _pass;

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
                    "Login with email",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF7883B4),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                      setState(() {
                        _email = val;
                      });
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
                      setState(() {
                        _pass = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Pattern pattern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regex = new RegExp(pattern);

                      if (regex.hasMatch(_email ?? '') || _email != null) {
                        context.read<AuthService>().sendPasswordReset(_email);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Password Reset Link has been sent to $_email',
                          ),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Enter a valid email first',
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        color: Color(0xFF394A93),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SampleAppButton(
                    text: "Login",
                    action: () async {
                      if (_formKey.currentState.validate()) {
                        String result = await context
                            .read<AuthService>()
                            .signIn(email: _email, password: _pass);
                        if (result != 'Signed in') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              result,
                            ),
                            backgroundColor: Colors.red,
                          ));
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
                        "Sign Up",
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
