import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final Function()? onTap; // Correct syntax for function type parameter

  CustomeButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 250,
          height: 45,
          decoration: BoxDecoration(
            color:Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
