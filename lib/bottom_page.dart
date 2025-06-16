import 'package:flutter/material.dart';
import 'package:women_safety_app/bottom_screens/review_page.dart';
import 'package:women_safety_app/bottom_screens/chat_page.dart';
import 'package:women_safety_app/bottom_screens/contacts_page.dart';

import 'package:women_safety_app/bottom_screens/profile_page.dart';
import 'package:women_safety_app/home_screen.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    // HomeScreen(),
    ContactsPage(),
    ChatPage(),
    ProfilePage(),
    ReviewPage(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              label: 'home',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'contact',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'chats',
              icon: Icon(
                Icons.chat,
              )),
          BottomNavigationBarItem(
              label: 'profile',
              icon: Icon(
                Icons.person,
              )),
          BottomNavigationBarItem(
              label: 'Reviews',
              icon: Icon(
                Icons.reviews,
              )),
        ],
      ),
    );
  }
}
