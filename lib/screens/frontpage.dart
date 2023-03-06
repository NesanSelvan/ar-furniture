import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  FrontPage({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.deepPurple.shade100),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, "showdata");
                Navigator.pushNamed(context, "ar_screen");
              },
              child: Text("Ar")),
          IconButton(
              onPressed: () {
                _signOut();
                Navigator.pushReplacementNamed(context, "login_screen");
              },
              icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
