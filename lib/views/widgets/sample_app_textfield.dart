import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SampleAppTextField extends StatefulWidget {
  Function onChanged, validator;
  String hintText;
  bool isPassword, showPass;
  SampleAppTextField(
      {Key key,
      this.onChanged,
      this.hintText,
      this.validator,
      this.isPassword = false,
      this.showPass = true})
      : super(key: key);

  @override
  _SampleAppTextFieldState createState() => _SampleAppTextFieldState();
}

class _SampleAppTextFieldState extends State<SampleAppTextField> {
  void togglePass() {
    if (widget.showPass) {
      setState(() {
        widget.showPass = false;
      });
    } else {
      setState(() {
        widget.showPass = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: .8.sw,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0xFFB5B8D5),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ], borderRadius: BorderRadius.circular(4.0)),
          child: TextFormField(
            maxLines: 1,
            validator: widget.validator,
            obscureText: !widget.showPass ? true : false,
            onChanged: widget.onChanged,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(width: 1, color: Colors.red),
              ),
              errorStyle: TextStyle(fontSize: 14, height: 0),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hintText,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              hintStyle: TextStyle(
                color: Color(0xFFB5B8D5),
                fontSize: 16,
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Visibility(
            visible: widget.isPassword,
            child: IconButton(
              splashRadius: 1,
              onPressed: togglePass,
              icon: Icon(Icons.remove_red_eye),
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
