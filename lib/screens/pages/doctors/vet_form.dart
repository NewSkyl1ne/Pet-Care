import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddVetForm extends StatefulWidget {
  @override
  _AddVetFormState createState() => _AddVetFormState();
}

class _AddVetFormState extends State<AddVetForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String? email;
  String? location;
  String? fee; // New field
  String? geolocation; // New field
  String? registeredNumber; // New field
  List<String>? availableDays = [];
  List<String>? availableHours = [];
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> hoursOfDay = [
    '9:00 AM - 12:00 PM',
    '1:00 PM - 4:00 PM',
    '5:00 PM - 8:00 PM',
    '9:00 PM - 11:00 PM',
  ];

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      final FirebaseFirestore _db = FirebaseFirestore.instance;
      await _db.collection('available_veterinarians').add({
        'name': name,
        'phone': phone,
        'email': email,
        'location': location,
        'fee': fee, // New field
        'geolocation': geolocation, // New field
        'registered_number': registeredNumber, // New field
        'availableDays': availableDays,
        'availableHours': availableHours,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Veterinarian'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) => name = value,
                ),
                // Other TextFormField widgets for phone, email, location...

                // New TextFormField widgets for additional fields
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter fee',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter fee';
                    }
                    return null;
                  },
                  onSaved: (value) => fee = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter geolocation',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter geolocation';
                    }
                    return null;
                  },
                  onSaved: (value) => geolocation = value,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter registered number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter registered number';
                    }
                    return null;
                  },
                  onSaved: (value) => registeredNumber = value,
                ),

                // Existing code for availableDays and availableHours...

                // ElevatedButton for form submission
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Add Veterinarian'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
