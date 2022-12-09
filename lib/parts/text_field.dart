import 'package:flutter/material.dart';

class NTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool expands;

  const NTextField({
    super.key,
    required this.controller,
    this.expands = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        textInputAction: TextInputAction.none,
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          // labelText: "send message",
          filled: true,
          fillColor: Colors.grey.shade700,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
