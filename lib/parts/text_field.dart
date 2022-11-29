import 'package:flutter/material.dart';

class NTextField extends StatelessWidget {
  final TextEditingController controller;

  const NTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "send message",
          filled: true,
          fillColor: Colors.grey.shade700,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
