import 'package:flutter/material.dart';
import 'package:tudu/colors.dart';

class Button extends StatelessWidget {

  final String name;
  VoidCallback onPressed; //VoidCallback means it wont return anything, it is simply a gesture detector

  Button({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: darkBlue,
      child: Text(name),
    );
  }
}
