import 'package:flutter/material.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onTap; // Changed Function? to VoidCallback
  final int? quoteIndex;

  const CustomAppBar({super.key, required this.onTap, this.quoteIndex});

  @override
  Widget build(BuildContext context) {
    // Check if quoteIndex is not null
    final String quote = quoteIndex != null ? sweetSayings[quoteIndex!] : "";

    return InkWell(
      onTap: onTap, // Call the onTap function passed from the parent widget
      child: Container(
        child: Text(
          quote,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
