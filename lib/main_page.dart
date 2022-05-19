import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_app/main.dart';
import 'package:crud_firebase_app/model/user.dart';
import 'package:crud_firebase_app/user_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListTile();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
