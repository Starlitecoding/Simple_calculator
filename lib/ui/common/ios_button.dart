import 'package:flutter/material.dart';

class IosButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const IosButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: onPressed,
        color: _getColor(text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(
          text,
          style: TextStyle(fontSize: 38, color: _getTextColor(text)),
        ),
      ),
    );
  }

  Color _getColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '=' ||
        text == '-') {
      return const Color(0xFFFF9500);
    }

    if (text == 'C' || text == 'AC' || text == '(' || text == ')') {
      return const Color(0xFFD4D4D2);
    }

    return const Color(0xFF505050);
  }

  Color _getTextColor(String text) {
    if (text == 'C' || text == 'AC' || text == '(' || text == ')') {
      return const Color(0xFF1C1C1C); // Черный текст для серых кнопок
    }
    return Colors.white; // Белый текст для всех остальных кнопок
  }
}
