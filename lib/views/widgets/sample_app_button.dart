import 'package:flutter/material.dart';

class SampleAppButton extends StatefulWidget {
  String text;
  Function action;
  SampleAppButton({Key key, this.text, this.action}) : super(key: key);

  @override
  _SampleAppButtonState createState() => _SampleAppButtonState();
}

class _SampleAppButtonState extends State<SampleAppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          color: Color(0xFFCFD3E4),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFAFB5D2),
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            "${widget.text}",
            style: TextStyle(
              color: Color(0xFF515F9F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
