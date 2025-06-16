import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/utils/constants.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  @override
  initState() {
    super.initState();
    askPermissions();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }

  handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(context, "access to the contacts denied by user");
    } else {
      dialogueBox(context, "may contacts does not exist in this device");
    }
  }

  Future<PermissionStatus> getContactPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contacts.length == 0
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "search contact",
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Contact contact = contacts[index];
                        return ListTile(
                            title: Text(contact.displayName!),
                            subtitle: Text(contact.phones!.elementAt(0).value!),
                            leading: contact.avatar != null &&
                                    contact.avatar!.length > 0
                                ? CircleAvatar(
                                    backgroundColor: primarayColor,
                                    backgroundImage: MemoryImage(
                                      contact.avatar!,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: primarayColor,
                                    child: Text(
                                      contact.initials(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ));
                      }),
                ),
              ],
            ),
    );
  }
}
