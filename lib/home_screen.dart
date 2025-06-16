import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:women_safety_app/bottom_page.dart';
import 'package:women_safety_app/emergency_contact_info.dart';
import 'package:women_safety_app/login_screen.dart';
import 'package:women_safety_app/register_screen.dart';
import 'package:women_safety_app/utils/constants.dart';
import 'package:women_safety_app/widgets/customCarouel.dart';
import 'package:women_safety_app/widgets/custom_appBar.dart';
import 'package:women_safety_app/widgets/emergency.dart';
import 'package:women_safety_app/widgets/live_save.dart';
import 'package:women_safety_app/widgets/safe_home/SafeHome.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 2;

  void changeQuoteIndex() {
    setState(() {
      qIndex = Random().nextInt(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(children: [
                  CustomAppBar(
                    quoteIndex: qIndex,
                    onTap:
                        changeQuoteIndex, // Pass the function to update the quote index
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        CustomCarouel(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Emergency',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Emergency(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Explore LiveSave',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        LiveSafe(),
                        SafeHome(),
                      ],
                    ),
                  ),
                  // Add other widgets here if needed
                  BottomAppBar(
                    elevation: 8.0,
                    color: Colors.white,
                    shape: CircularNotchedRectangle(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(Icons.home,
                                size: 28.0, color: Color(0xfffc3b77)),
                            onPressed: () {
                              // Navigate to the home screen
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.people,
                                size: 28.0, color: Color(0xfffc3b77)),
                            onPressed: () {
                              goto(context, EmergencyContactsScreen());
                            },
                          ),
                          // Additional IconButton for logout and registration
                          IconButton(
                            icon: Icon(Icons.logout,
                                size: 28.0,
                                color: Color(
                                    0xfffc3b77)), // Example icon for logout
                            onPressed: () {
                              goto(context, LoginScreen());
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.person_add,
                                size: 28.0,
                                color: Color(
                                    0xfffc3b77)), // Example icon for registration
                            onPressed: () {
                              goto(context, RegisterChildScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
