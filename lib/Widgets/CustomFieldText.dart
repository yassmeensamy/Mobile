import 'package:flutter/material.dart';

class CustomFieldText extends StatelessWidget {
  String Label;
   String? Function(String?)? validator;
   bool obscureText; // Validation function parameter
   TextEditingController controller;
  CustomFieldText({  required this.validator, required this.Label ,required this.obscureText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextFormField(
       autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText:obscureText,
        controller: controller,
        validator: validator, // Use the validation function passed as a parameter
        decoration: InputDecoration(
          labelText: Label,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
