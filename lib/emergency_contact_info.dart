import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:women_safety_app/emergency_contact_provider.dart';
import 'package:women_safety_app/widgets/custom_appBar.dart';

class EmergencyContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
      ),
      body: EmergencyContactsSection(),
    );
  }
}

class EmergencyContactsSection extends StatefulWidget {
  @override
  _EmergencyContactsSectionState createState() =>
      _EmergencyContactsSectionState();
}

class _EmergencyContactsSectionState extends State<EmergencyContactsSection> {
  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    var emergencyContactsProvider =
        Provider.of<EmergencyContactsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'Parents/Gaurdians',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: emergencyContactsProvider.emergencyContacts.length,
            itemBuilder: (context, index) {
              return Card(
                // Wrap the ListTile with a Card widget
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  title:
                      Text(emergencyContactsProvider.emergencyContacts[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Ensure that the Row takes minimum space
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone), // First icon
                        onPressed: () => {_callNumber('9411703021')},
                      ),
                      SizedBox(width: 8.0), // Add space between the icons
                      IconButton(
                        icon: Icon(Icons.delete), // Second icon
                        onPressed: () {
                          emergencyContactsProvider
                              .removeEmergencyContact(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      // Perform additional validation if needed
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      emergencyContactsProvider
                          .addEmergencyContact(_phoneController.text);
                      _phoneController.clear();
                    }
                  },
                  child: Text('Add Contact'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
