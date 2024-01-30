import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hinttext;
  final bool obscuretext;
  final FocusNode focusnode;
  final TextEditingController controller;


  const MyTextField({super.key,
    required this.hinttext,
    required this.obscuretext,
    required this.controller,
    required this.focusnode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        focusNode: focusnode,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 3,
            ),
          ),
          hintText: hinttext,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        obscureText: obscuretext,
      ),
    );
  }
}
