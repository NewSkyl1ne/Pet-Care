import 'package:flutter/material.dart';
import 'package:pet_care/screens/home/home_screen.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Edit your profile here'),
      ),
    );
  }
}
