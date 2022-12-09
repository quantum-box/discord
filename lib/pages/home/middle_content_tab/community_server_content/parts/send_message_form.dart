import 'package:discord_clone/parts/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessageForm extends StatelessWidget {
  const SendMessageForm({
    Key? key,
    required this.controller,
    required this.onSubmit,
    required this.submitLabel,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final String submitLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          left: 12,
          right: 12,
          bottom: 12,
        ),
        child: Row(
          children: [
            Flexible(
              child: Shortcuts(
                shortcuts: {
                  LogicalKeySet(
                          LogicalKeyboardKey.enter, LogicalKeyboardKey.meta):
                      VoidCallbackIntent(onSubmit),
                },
                child: NTextField(
                  controller: controller,
                  expands: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  submitLabel,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
