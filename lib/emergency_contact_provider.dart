import 'package:flutter/material.dart';

class EmergencyContactsProvider extends ChangeNotifier {
  List<String> _emergencyContacts = [];

  List<String> get emergencyContacts => _emergencyContacts;

  void addEmergencyContact(String phoneNumber) {
    _emergencyContacts.add(phoneNumber);
    notifyListeners();
  }

  void removeEmergencyContact(int index) {
    _emergencyContacts.removeAt(index);
    notifyListeners();
  }
}
