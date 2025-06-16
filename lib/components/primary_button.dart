import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {required this.onPressed, required this.title, this.loading = false});
  final String title;
  final Function onPressed;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primarayColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
