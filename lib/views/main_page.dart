import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_app/model/user.dart';
import 'package:crud_firebase_app/views/user_page.dart';
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
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Ada Kesalahan ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final users = snapshot.data;
            return ListView(
              children: users!.map(buildUser).toList(),
            );
          }
          return Center();
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

  deleteUser(String id) {
    final docUser = FirebaseFirestore.instance.collection('users').doc(id);

    docUser.delete();
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text("${user.age}"),
        ),
        title: Text("${user.name}"),
        subtitle: Text("${user.birthday!.toIso8601String()}"),
        trailing: Container(
          width: 100,
          // color: Colors.black,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  ;
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
