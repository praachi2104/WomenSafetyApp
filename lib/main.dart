import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:women_safety_app/bottom_page.dart';
import 'package:women_safety_app/db/shared_pref.dart';
import 'package:women_safety_app/emergency_contact_provider.dart';
import 'package:women_safety_app/login_screen.dart';
import 'package:women_safety_app/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreference.init();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => EmergencyContactsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: MySharedPreference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          print("User type: ${snapshot.data}");
          if (snapshot.data == null) {
            print("No user logged in, showing login screen");
            return LoginScreen();
          }
          if (snapshot.data == "child") {
            print("Child user logged in, showing bottom page");
            return BottomPage();
          }
          // Handle other cases or show progress indicator
          print("User type unknown, showing progress indicator");
          return progressIndicator(context);
        },
      ),
    );
  }
}

// class CheckAuth extends StatelessWidget {
//   // const CheckAuth({super.key});
//   checkData() {
//     if (MySharedPreference.getUserType() == 'parent') {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
