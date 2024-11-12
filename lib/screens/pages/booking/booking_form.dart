import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookingForm extends StatefulWidget {
  @override
  _AddBookingFormState createState() => _AddBookingFormState();
}

class _AddBookingFormState extends State<AddBookingForm> {
  final _formKey = GlobalKey<FormState>();
  final hoursOfDay = [    '9:00 AM - 12:00 PM',    '1:00 PM - 4:00 PM',    '5:00 PM - 8:00 PM',    '9:00 PM - 11:00 PM',  ];

  TextEditingController petNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController appointmentTypeController = TextEditingController();
  TextEditingController reasonForVisitController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Booking'),
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
                labelText: 'Pet Name',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter pet name';
                }
                return null;
              },
              controller: petNameController,
            ),

              SizedBox(height: 16),

              TextFormField(
              decoration: InputDecoration(
                labelText: 'Owner Name',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400]!,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter owner name';
                }
                return null;
              },
              controller: ownerNameController,
            ),
                SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Appointment Date',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  hintText: 'Select date',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
                controller: dateController,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    dateController.text = selectedDate.toString().substring(0, 10);
                  }
                },
              ),
            SizedBox(height: 16),


              TextFormField(
  decoration: InputDecoration(
    labelText: 'Appointment Time',
    labelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.grey[800],
    ),
    hintText: 'Select time',
    hintStyle: TextStyle(
      fontSize: 14,
      color: Colors.grey[500],
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return 'Please select a time';
    }
    return null;
  },
  controller: timeController,
  onTap: () async {
    String? selectedTime = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  'Select Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: hoursOfDay
                      .map(
                        (hour) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context, hour);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  hour,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (selectedTime != null) {
      timeController.text = selectedTime;
    }
  },
),

                              SizedBox(height: 16),

              TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Status',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter status';
                    }
                    return null;
                  },
                  controller: statusController,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Appointment Type',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter appointment type';
                    }
                    return null;
                  },
                  controller: appointmentTypeController,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Reason for Visit',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter reason for visit';
                    }
                    return null;
                  },
                  controller: reasonForVisitController,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Information',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter contact information';
                    }
                    return null;
                  },
                  controller: contactInfoController,
                ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                                    onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance.collection('bookings').add({
                        'petName': petNameController.text,
                        'ownerName': ownerNameController.text,
                        'date': dateController.text,
                        'time': timeController.text,
                        'status': statusController.text,
                        'appointmentType': appointmentTypeController.text,
                        'reasonForVisit': reasonForVisitController.text,
                        'contactInfo': contactInfoController.text,
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Booking added successfully')));
                        petNameController.clear();
                        ownerNameController.clear();
                        dateController.clear();
                        timeController.clear();
                        statusController.clear();
                        appointmentTypeController.clear();
                        reasonForVisitController.clear();
                        contactInfoController.clear();
                      }).catchError((error) => print('Failed to add booking: $error'));
                    }
                  },
                  child: Text('Submit'),
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

                        
