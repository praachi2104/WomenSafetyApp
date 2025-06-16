import 'package:flutter/material.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({super.key, this.onMapFunction});
  final Function? onMapFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () => {
              onMapFunction!('pharmacies near me'),
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    'asset/pharmacy.png',
                    height: 22,
                  ),
                ),
              ),
            ),
          ),
          Text('Pharmacy'),
        ],
      ),
    );
  }
}
