import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.title, this.height, required this.onPressed});
  final VoidCallback onPressed;
  final String title;
  final double ? height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 80),
          backgroundColor: Colors.white70,
        ),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25
          ),
        )
    );
  }
}
