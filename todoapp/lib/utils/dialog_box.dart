import 'package:flutter/material.dart';
import 'package:todo_app/utils/dark_mode.dart';
import 'package:todo_app/utils/my_button.dart';
import 'package:provider/provider.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;


  DialogBox({Key? key, required this.controller, required this.onSave, required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<darkMode>(context);
    return AlertDialog(
     backgroundColor: themeProvider.isDarkMode ? Colors.grey[800] : Colors.yellow[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
               style: TextStyle(color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
                 hintStyle: TextStyle(color: themeProvider.isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(text: "Save", onPressed: onSave,  buttonColor: themeProvider.isDarkMode ? Colors.blue : Colors.green, // Adjust button color
                  textColor: Colors.white, borderRadius: 8,
                  
                  ),
                SizedBox(
                  width: 8,
                ),
                MyButton(text: "Cancel", onPressed: onCancel , buttonColor: themeProvider.isDarkMode ? Colors.red : Colors.orange, // Adjust button color
                  textColor: Colors.white,
                  borderRadius: 8,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
