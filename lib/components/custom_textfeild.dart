import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  CustomTextFeild(
      {this.controller,
      this.enable = true,
      this.check = true,
      this.focusNode,
      this.hintText,
      this.isPassword = false,
      this.keyboardtype,
      this.maxLines,
      this.onSave,
      this.prefix,
      this.suffix,
      this.textInputAction,
      this.validate});
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final String? Function(String?)? onSave;
  final int? maxLines;
  final bool isPassword;
  final bool enable;
  final bool check;
  final TextInputType? keyboardtype;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable == true ? true : enable,
      maxLines: maxLines == null ? 1 : maxLines,
      onSaved: onSave,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardtype == null ? TextInputType.name : keyboardtype,
      controller: controller,
      validator: validate,
      obscureText: isPassword == false ? false : isPassword,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        labelText: hintText ?? "hint text...",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Color(0xFF909A9E),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
