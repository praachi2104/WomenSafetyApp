import 'package:flutter/material.dart';

Color primarayColor = Color(0xfffc3b77);

void goto(BuildContext context, Widget nextScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen,
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Color(0xfffc3b77),
      strokeWidth: 4,
      color: Colors.red,
    ),
  );
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}
