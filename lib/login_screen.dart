import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_app/components/custom_textfeild.dart';
import 'package:women_safety_app/components/primary_button.dart';
import 'package:women_safety_app/components/secondary_button.dart';
import 'package:women_safety_app/forget_password.dart';
import 'package:women_safety_app/home_screen.dart';
import 'package:women_safety_app/main.dart';
import 'package:women_safety_app/register_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({super.key});
  bool isPasswordShown = true;
  final _formKey = GlobalKey<
      FormState>(); //global key to manage state and preform validate and onSave.
  final _formData = Map<String, Object>(); //map to store form data
  bool isLoading = false;

  _onSubmit() async {
    _formKey.currentState!.save(); //save all form fields
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formData['email'].toString(),
              password: _formData['password'].toString());
      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userCredential.user!.uid)
        //     .get()
        //     .then((value) {
        //   // if (value['type'] == 'parent') {
        //   //   print(value['type']);
        //   //   MySharedPreference.saveUserType('parent');
        //   //   goto(context, ParentHomeScreen());
        //   // } else {
        //   //   MySharedPreference.saveUserType('child');
        //   //   goto(context, HomeScreen());
        //   // }
        // });
        goto(context, HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        dialogueBox(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialogueBox(context, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      dialogueBox(context, 'An unexpected error occurred: $e');
      print('An unexpected error occurred: $e');
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            isLoading
                ? progressIndicator(context)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "USER LOGIN",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Image.asset(
                                'asset/logo.png',
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextFeild(
                                  hintText: 'enter email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onSave: (email) {
                                    _formData['email'] = email ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 3 ||
                                        !email.contains("@")) {
                                      return 'enter correct email';
                                    }
                                  },
                                ),
                                CustomTextFeild(
                                  hintText: 'enter password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.vpn_key_rounded),
                                  validate: (password) {
                                    if (password!.isEmpty ||
                                        password.length < 7) {
                                      return 'enter correct password';
                                    }
                                    return null;
                                  },
                                  onSave: (password) {
                                    _formData['password'] = password ?? "";
                                  },
                                  suffix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: isPasswordShown
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                ),
                                PrimaryButton(
                                    title: 'LOGIN',
                                    onPressed: () {
                                      progressIndicator(context);
                                      if (_formKey.currentState!.validate()) {
                                        _onSubmit();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Frogot Password?",
                                style: TextStyle(fontSize: 18),
                              ),
                              SecondaryButton(
                                  title: 'click here',
                                  onPressed: () {
                                    goto(context, ForgotPasswordScreen());
                                  }),
                            ],
                          ),
                        ),
                        SecondaryButton(
                            title: 'register yourself',
                            onPressed: () {
                              goto(context, RegisterChildScreen());
                            }),
                        // SecondaryButton(
                        //     title: 'Register as Parent',
                        //     onPressed: () {
                        //       goto(context, RegisterChildScreen());
                        //     }),
                      ],
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
