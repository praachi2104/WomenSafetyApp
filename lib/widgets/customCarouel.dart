import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:women_safety_app/utils/quotes.dart';

class CustomCarouel extends StatelessWidget {
  const CustomCarouel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0, // Set the height of the carousel
        autoPlay: true, // Enable auto-scrolling
        autoPlayInterval: Duration(seconds: 3),
        enlargeCenterPage: true, // Set auto-scroll interval
      ),
      items: List.generate(
        imagePaths.length,
        (index) => Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imagePaths[index]),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
