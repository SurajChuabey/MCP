import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;

  const AppBarIcon({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.green,
    this.borderColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 169, 230, 171),
                foregroundColor: Colors.green.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  side: const BorderSide(color: Color.fromARGB(1, 162, 211, 211),width: 1), // Border
                ),
                ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          );
  }
}
