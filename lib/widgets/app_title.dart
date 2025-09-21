import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final double fontSize;

  const AppTitle({super.key, this.fontSize = 36, required String text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
        children: const [
          TextSpan(
            text: "Shiksha",
            style: TextStyle(color: Color(0xFF007BFF)), // Blue
          ),
          TextSpan(
            text: "Setu",
            style: TextStyle(color: Color(0xFFFF6B00)), // Orange
          ),
        ],
      ),
    );
  }
}
