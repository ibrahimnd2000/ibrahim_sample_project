import 'package:flutter/material.dart';

class SampleAppListItem extends StatefulWidget {
  String name;
  SampleAppListItem({Key key, this.name}) : super(key: key);

  @override
  _SampleAppListItemState createState() => _SampleAppListItemState();
}

class _SampleAppListItemState extends State<SampleAppListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xFFF2F4FB),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/images/default-avatar.png')),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                widget.name ?? "Unknown",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
