import 'package:flutter/material.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';



Widget neumorphicButton(String text, VoidCallback onPressed) {
  Offset distance = Offset(8, 8);
  double blur = 18.0;
  // bool isPressed = true;

  return Container(
    margin: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.grey[300], // Background color of the button
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(1.0),
          offset: -distance,
          blurRadius: blur,
           // Applying inset shadow
        ),
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          offset: distance,
          blurRadius: blur,
        ),
      ],
    ),
    child: Material(
      color:
          Colors.transparent, // Transparent to show the container's decoration
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 36),
          ),
        ),
      ),
    ),
  );
}
