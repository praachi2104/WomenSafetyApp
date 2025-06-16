import 'package:flutter/material.dart';

class SafetyTips extends StatelessWidget {
  final List<String> tips = [
    "Stay aware of your surroundings.",
    "Avoid walking alone at night.",
    "Keep your phone charged and with you at all times.",
    "Let someone know where you are going.",
    "Trust your instincts."
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Text(
            'Safety Tips',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tips.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.check, color: Colors.green),
                title: Text(tips[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
