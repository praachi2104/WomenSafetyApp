import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/components/custom_textfeild.dart';
import 'package:women_safety_app/components/primary_button.dart';
import 'package:women_safety_app/utils/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        dialogueBox(context, 'Password reset link sent to your email');
      } on FirebaseAuthException catch (e) {
        dialogueBox(context, e.message.toString());
      } catch (e) {
        dialogueBox(context, 'An error occurred. Please try again.');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Enter your email to receive a password reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                CustomTextFeild(
                  controller: _emailController,
                  hintText: 'Enter email',
                  textInputAction: TextInputAction.done,
                  keyboardtype: TextInputType.emailAddress,
                  prefix: Icon(Icons.email),
                  validate: (email) {
                    if (email!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                            .hasMatch(email)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : PrimaryButton(
                        title: 'Reset Password',
                        onPressed: _resetPassword,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
