import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Auth/authentication.dart';

class profileScreen extends StatelessWidget {
  profileScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  gsignOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              gsignOut();
              signOut();
              Navigator.pop(context); // pop current screen

            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("Logged in as: ${user.email!}"),
      ),
    );
  }
}
