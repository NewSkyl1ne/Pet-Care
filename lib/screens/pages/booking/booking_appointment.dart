import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking_form.dart';

class BookingAppointment extends StatelessWidget {
  final String doctorId;

  const BookingAppointment({Key? key, required this.doctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('available_veterinarians').doc(doctorId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final doctorData = snapshot.data?.data() as Map<String, dynamic>?;

        if (doctorData == null) {
          return Text('Doctor not found.');
        }

        final List<String> hoursOfDay = doctorData['availableHours'] != null ? List<String>.from(doctorData['availableHours']) : [];

        return Container(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.fromLTRB(0 * fem, 18 * fem, 0 * fem, 0 * fem),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffdaf2f7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20 * fem, 0 * fem, 0 * fem, 40 * fem),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 51 * fem,
                      height: 41 * fem,
                      child: Image.asset(
                        'assets/images/button.png',
                        width: 51 * fem,
                        height: 41 * fem,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 371 * fem,
                  height: 604 * fem,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0 * fem,
                        top: 0 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 371 * fem,
                            height: 335 * fem,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20 * fem),
                              child: Image.asset(
                                'assets/images/doctor-1-Rc4.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0 * fem,
                        top: 272 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 360 * fem,
                            height: 522 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30 * fem),
                                color: Color(0xffffffff),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20 * fem),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30 * fem, 0 * fem, 30 * fem, 0 * fem),
                                    child: Text(
                                      'Name: ${doctorData['name'] ?? 'N.A'}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4725 * fem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30 * fem, 0 * fem, 30 * fem, 0 * fem),
                                    child: Text(
                                      'Location: ${doctorData['location'] ?? 'N.A'}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4725 * fem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30 * fem, 0 * fem, 30 * fem, 0 * fem),
                                    child: Text(
                                      'Available Hours:',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4725 * fem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: hoursOfDay.map((hour) {
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(30 * fem, 0 * fem, 30 * fem, 0 * fem),
                                        child: Text(
                                          hour,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400,
                                            height: 1.4725 * fem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: 20 * fem),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 16.0 * fem),
                                        child: SizedBox(
                                          width: 150.0,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => AddBookingForm()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(vertical: 24.0),
                                              textStyle: TextStyle(fontSize: 18.0),
                                            ),
                                            child: Text('Book Now'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
