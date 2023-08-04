import 'package:flutter/material.dart';
import 'package:todo/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //inputs:
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "New task"),
            ),
            const SizedBox(
              height: 20,
            ),
            // save and cancel button:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                    text: 'Cancel',
                    onPressed: () {
                      onCancel();
                    }),
                const SizedBox(width: 8),
                MyButton(
                    text: 'Save',
                    onPressed: () {
                      onSave();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
