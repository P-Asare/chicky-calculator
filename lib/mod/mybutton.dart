import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String val;
  final Color buttonCol;
  final Color textCol;
  final dynamic clickAction;

  MyButton({
    super.key,
    required this.buttonCol,
    required this.textCol,
    required this.val,
    this.clickAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickAction,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: buttonCol,
            child: Center(
              child: Text(
                val,
                style: TextStyle(
                  color: textCol,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
