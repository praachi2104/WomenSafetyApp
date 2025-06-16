import 'package:flutter/material.dart';
import 'package:women_safety_app/widgets/emergencies/PoliceEmergency.dart';
import 'package:women_safety_app/widgets/emergencies/ambulanceEmergency.dart';
import 'package:women_safety_app/widgets//emergencies/armyEmergency.dart';
import 'package:women_safety_app/widgets//emergencies/firebrigadeEmergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            PoliceEmergency(),
            AmbulanceEmergency(),
            firebrigadeEmergency(),
            armyEmergency(),
          ],
        ));
  }
}
