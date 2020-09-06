import 'package:flutter/material.dart';


class CustomText extends StatefulWidget {
  String text;
  final TextStyle textStyle;
  CustomText(String text, {this.textStyle}) {
    this.text = text;
  }
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {

  @override
  Widget build(BuildContext context) {
    if(widget.text=="") return SizedBox();
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 1.5,
            shadowColor: Colors.grey[400],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.text,
                style: widget.textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}