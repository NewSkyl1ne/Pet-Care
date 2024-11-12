import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final icon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.obscureText,
      required this.hintText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(174, 244, 201, 228)),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          prefixIcon: icon,
          fillColor: Colors.grey[300],
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
