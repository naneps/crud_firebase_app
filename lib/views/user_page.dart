import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_app/model/user.dart';
import 'package:date_time_field/date_time_field.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerBirthDay = DateEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
                controller: controllerName, decoration: decoration("Name")),
            TextField(controller: controllerAge, decoration: decoration("Age")),
            DateTimeField(
              controller: controllerBirthDay,
              decoration: decoration('Birthday'),
              // onChanged: ,
            ),
            // DateTimeField()
            ElevatedButton(
              onPressed: () {
                final user = User(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  birthday: controllerBirthDay.date,
                );
                print(controllerBirthDay.date);
                createUser(user);
                Navigator.pop(context, user);
              },
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration decoration(String hintText) {
    return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
    );
  }

  Future createUser(User user) async {
    final docUser = await FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    final json = user.toJson();
    print(json);
    await docUser.set(json);
  }
}
