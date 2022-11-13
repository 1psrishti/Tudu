import 'package:flutter/material.dart';
import 'package:tudu/colors.dart';
import 'button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;

  DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightBlue,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: "Add a new task",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  name: "Save",
                  onPressed: onSave,
                ),
                const SizedBox(width: 8),
                Button(
                  name: "Cancel",
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.clear();
                  },
                ),
              ],
            )
          ],
        ),
        // height: 200,
        // color: Colors.yellow,
      ),
    );
  }
}
