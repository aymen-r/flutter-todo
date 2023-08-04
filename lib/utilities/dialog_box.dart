import 'package:flutter/material.dart';
import 'package:todo/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;

  String type;
  String? initialValue;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.type,
      required this.controller,
      required this.onSave,
      required this.onCancel,
      this.initialValue});
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
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: type == 'edit' ? "Edit Task" : "New task"),
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
