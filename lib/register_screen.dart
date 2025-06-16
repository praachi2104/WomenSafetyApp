import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/components/custom_textfeild.dart';
import 'package:women_safety_app/components/primary_button.dart';
import 'package:women_safety_app/components/secondary_button.dart';
// import 'package:women_safety_app/child/child_login_screen.dart';
import 'package:women_safety_app/login_screen.dart';
import 'package:women_safety_app/model/user_model.dart';
import 'package:women_safety_app/utils/constants.dart';

class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<
      FormState>(); //global key to manage state and preform validate and onSave.
  final _formData = Map<String, Object>(); //map to store form data
  bool isLoading = false;
  bool isRetypePasswordShown = true;

  _onSubmit() async {
    _formKey.currentState!.save(); //save all form feilds
    if (_formData['password'] != _formData['rpassword']) {
      dialogueBox(
        context,
        "password and confirm password should be equal",
      );
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _formData['cemail'].toString(),
          password: _formData['password'].toString(),
        );
        if (userCredential.user != null) {
          setState(() {
            isLoading = true;
          });
          final v = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            childEmail: _formData['cemail'].toString(),
            parentEmail: _formData['gemail'].toString(),
            id: v,
            type: 'child',
          );
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            setState(() {
              isLoading = false;
            });
            goto(context, LoginScreen());
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          dialogueBox(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          dialogueBox(context, 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
        dialogueBox(context, e.toString());
      }
      //   try {
      //     FirebaseAuth auth = FirebaseAuth.instance;
      //     auth
      //         .createUserWithEmailAndPassword(
      //           email: _formData['email'].toString(),
      //           password: _formData['password'].toString(),
      //         )
      //         .then((v) async {});
      //   } on FirebaseAuthException catch (e) {
      //     dialogueBox(context, e.toString());
      //   } catch (e) {
      //     dialogueBox(context, e.toString());
      //   }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  'REGISTER AS CHILD',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: primarayColor),
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
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextFeild(
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.name,
                                    hintText: 'enter name',
                                    prefix: Icon(Icons.person),
                                    validate: (name) {
                                      if (name!.isEmpty || name.length < 3) {
                                        return 'enter correct name';
                                      }
                                      return null;
                                    },
                                    onSave: (name) {
                                      //email is the value of current textfield
                                      _formData['name'] = name ?? "";
                                    },
                                  ),
                                  CustomTextFeild(
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.phone,
                                    hintText: 'enter phone',
                                    prefix: Icon(Icons.phone),
                                    validate: (phone) {
                                      if (phone!.isEmpty || phone.length < 10) {
                                        return 'enter correct phone';
                                      }
                                      return null;
                                    },
                                    onSave: (phone) {
                                      //email is the value of current textfield
                                      _formData['phone'] = phone ?? "";
                                    },
                                  ),
                                  CustomTextFeild(
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    hintText: 'enter email',
                                    prefix: Icon(Icons.person),
                                    validate: (cemail) {
                                      if (cemail!.isEmpty ||
                                          cemail.length < 3 ||
                                          !cemail.contains("@")) {
                                        return 'enter correct email';
                                      }
                                      return null;
                                    },
                                    onSave: (cemail) {
                                      //email is the value of current textfield
                                      _formData['cemail'] = cemail ?? "";
                                    },
                                  ),
                                  CustomTextFeild(
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    hintText: 'enter guardian email',
                                    prefix: Icon(Icons.person),
                                    validate: (gemail) {
                                      if (gemail!.isEmpty ||
                                          gemail.length < 3 ||
                                          !gemail.contains("@")) {
                                        return 'enter correct guardian email';
                                      }
                                      return null;
                                    },
                                    onSave: (gemail) {
                                      //email is the value of current textfield
                                      _formData['gemail'] = gemail ?? "";
                                    },
                                  ),
                                  CustomTextFeild(
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
                                    isPassword: isPasswordShown,
                                    hintText: 'enter password',
                                    prefix: Icon(Icons.vpn_key_rounded),
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
                                  CustomTextFeild(
                                    validate: (password) {
                                      if (password!.isEmpty ||
                                          password.length < 7) {
                                        return 'enter correct password';
                                      }
                                      return null;
                                    },
                                    onSave: (password) {
                                      _formData['rpassword'] = password ?? "";
                                    },
                                    isPassword: isRetypePasswordShown,
                                    hintText: 'confirm password',
                                    prefix: Icon(Icons.vpn_key_rounded),
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isRetypePasswordShown =
                                                !isRetypePasswordShown;
                                          });
                                        },
                                        icon: isRetypePasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                  ),
                                  PrimaryButton(
                                    title: 'REGISTER',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate())
                                        _onSubmit();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SecondaryButton(
                                    onPressed: () {
                                      goto(context, LoginScreen());
                                    },
                                    title: 'login with your account')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
