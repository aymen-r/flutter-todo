import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color:
          text == 'Cancel' ? Colors.red[400] : Theme.of(context).primaryColor,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
