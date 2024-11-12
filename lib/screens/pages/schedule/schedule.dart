import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pet_care/screens/booking/booking_form.dart';
import 'package:pet_care/screens/pages/booking/booking_list.dart';
import 'package:pet_care/screens/pages/booking/booking_appointment.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String locationFilter = 'All';
  List<String> locationOptions = [];

  @override
  Widget build(BuildContext context) {
    final double fem = MediaQuery.of(context).size.width / 360;

    return Material(
      child: FutureBuilder<QuerySnapshot>(
        future: _firestore.collection('available_veterinarians').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found.'));
          } else {
            final List<QueryDocumentSnapshot> doctors = snapshot.data!.docs;
            List<QueryDocumentSnapshot> filteredDoctors;
            final Set<String> uniqueLocations = Set<String>();

              for (var doctor in doctors) {
                final Map<String, dynamic> doctorData = doctor.data() as Map<String, dynamic>;
                final String? location = doctorData['location'];
                if (location != null) {
                  uniqueLocations.add(location);
                }
              }
              List<String> locationOptions = uniqueLocations.toList();
              locationOptions.insert(0, 'All');
              print(uniqueLocations);

              if (locationFilter == 'All') {
                filteredDoctors = doctors;
              } else if (uniqueLocations.contains(locationFilter)) {
                filteredDoctors = doctors.where((doctor) {
                  final doctorData = doctor.data() as Map<String, dynamic>?;
                  final doctorLocation = doctorData?['location'] as String?;
                  return doctorLocation == locationFilter;
                }).toList();
              } else {
                filteredDoctors = [];
              }


            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffdaf2f7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            12 * fem, 16 * fem, 0, 11 * fem),
                        child: Row(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  // This will navigate back to the previous screen
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  'assets/images/group-20.png',
                                  width: 51 * fem,
                                  height: 45 * fem,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 12 * fem, 14 * fem),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                      color: Colors.white,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookingList(),
                                          ),
                                        );
                                        // Show my bookings
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10 * fem,
                                            4 * fem, 10 * fem, 14 * fem),
                                        child: Center(
                                          child: Icon(Icons.calendar_today,
                                              size: 28 * fem),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 14 * fem),
                        width: double.infinity,
                        child: Text(
                          'Available Veterinarian',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Hanuman',
                            fontSize: 24 * fem,
                            fontWeight: FontWeight.w400,
                            height: 1.4725 * fem / fem,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8 * fem, horizontal: 16 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle the dropdown menu tap action
                              },
                              child: Text(
                                'Filters',
                                style: SafeGoogleFont(
                                  'Hanuman',
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4725 * fem / fem,
                                  color: Colors.white,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xff8acaca)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16 * fem),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8 * fem),
                           DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: locationFilter,
                                onChanged: (newValue) {
                                  setState(() {
                                    locationFilter = newValue!;
                                  });
                                },
                                items: locationOptions.map<DropdownMenuItem<String>>((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(
                                      option,
                                      style: SafeGoogleFont(
                                        'Hanuman',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4725 * fem / fem,
                                        color: locationFilter == option
                                            ? Color.fromARGB(255, 73, 190, 142)
                                            : const Color(0xff8acaca),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                style: TextStyle(color: Colors.black),
                                icon: Icon(Icons.arrow_drop_down),
                                iconEnabledColor: Color.fromARGB(255, 70, 206, 126),
                                iconSize: 28 * fem,
                                dropdownColor: Color.fromARGB(255, 208, 228, 218),
                              ),
                            ),

                          ],
                        ),
                      ),
                     Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 * fem, vertical: 8 * fem),
                        child: Center(
                          child: Text(
                            locationFilter,
                            style: SafeGoogleFont(
                              'Hanuman',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.4725 * fem / fem,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                      ListView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: filteredDoctors.length,
  itemBuilder: (BuildContext context, int index) {
    final Map<String, dynamic> details =
        (filteredDoctors[index].data() as Map<String, dynamic>)
            .cast<String, dynamic>();
    final detail = filteredDoctors[index];
    final String? image = details['image'];
    final List<dynamic>? availableDays =
        details['availableDays']
            ?.map((day) => day.toString().substring(0, 3))
            .toList();
    String available = 'N/A';

    if (availableDays != null && availableDays.isNotEmpty) {
      available = 'Yes';
    }
    final String? name = details['name'];
    final String? location = details['location'];
    final String? registeredNumber = details['registered_number'];

    return Container(
      margin: EdgeInsets.only(bottom: 16 * fem),
      padding: EdgeInsets.all(12 * fem),
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(20 * fem),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8 * fem,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16 * fem),
            width: 82 * fem,
            height: 86 * fem,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 * fem),
              image: image != null
                  ? DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: AssetImage('assets/images/doctor-1-YRv.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 if (registeredNumber != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12 * fem,
                            vertical: 6 * fem,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8 * fem,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'Registered Number: $registeredNumber',
                            style: SafeGoogleFont(
                              'Hanuman',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.4725 * fem / fem,
                              color: Colors.black,
                            ),
                          ),
                        ),
                                              
                      SizedBox(height: 8 * fem),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Available: \n',
                        style: SafeGoogleFont(
                          'Hanuman',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4725 * fem / fem,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        children: [
                          for (var day in [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ])
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    color: availableDays?.contains(
                                                day.replaceAll('day', '')) ??
                                            false
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                        ],
                        style: SafeGoogleFont(
                          'Hanuman',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4725 * fem / fem,
                          color: const Color(0xff8acaca),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4 * fem),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Doctor Name: ',
                        style: SafeGoogleFont(
                          'Hanuman',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4725 * fem / fem,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: name ?? 'N/A',
                        style: SafeGoogleFont(
                          'Hanuman',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4725 * fem / fem,
                          color: const Color(0xff8acaca),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4 * fem),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Location: ',
                        style: SafeGoogleFont(
                          'Hanuman',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4725 * fem / fem,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: location ?? 'N/A',
                        style: SafeGoogleFont(
                          'Hanuman',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4725 * fem / fem,
                          color: const Color(0xff8acaca),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12 * fem),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: SingleChildScrollView(
                                  child: BookingAppointment(doctorId: detail.id),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12 * fem,
                            vertical: 6 * fem,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8 * fem,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            'Book Now',
                            style: SafeGoogleFont(
                              'Hanuman',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.4725 * fem / fem,
                              color: Colors.black,
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
        ],
      ),
    );
  },
),


                        ],


                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
