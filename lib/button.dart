import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String buttonText;
  final Color color;
  final Color textColor;
  final buttonClick;

  Button({this.buttonText, this.color, this.textColor, this.buttonClick});

  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: buttonClick,
          child: Container(
          padding: EdgeInsets.all(6.0),
          alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.0)
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(color: textColor, fontSize: 18.0)
            ),
          ),
        ),
      ),
    );
  }
}