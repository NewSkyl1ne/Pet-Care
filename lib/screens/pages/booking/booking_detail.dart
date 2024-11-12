import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailScreen({required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffdaf2f7),
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('bookings')
              .doc(bookingId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final bookingData = snapshot.data!.data()!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Booking Details',
                  //   style: TextStyle(
                  //     fontSize: 24.0,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'Pacifico',
                  //   ),
                  // ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildBookingDetailRow(
                                  'Pet Name:', bookingData['petName']??'N/A'),
                              _buildBookingDetailRow(
                                  'Owner Name:', bookingData['ownerName']??'N/A'),
                              _buildBookingDetailRow(
                                  'Date:', bookingData['date']??'N/A'),
                              _buildBookingDetailRow(
                                  'Time:', bookingData['time']??'N/A'),
                              _buildBookingDetailRow(
                                  'Duration:', bookingData['duration']??'N/A'),
                              _buildBookingDetailRow(
                                  'Address:', bookingData['address']??'N/A'),
                              _buildBookingDetailRow(
                                  'Notes:', bookingData['notes']??'N/A'),
                              _buildBookingDetailRow(
                                  'Status:', bookingData['status']??'N/A'),
                              _buildBookingDetailRow(
                                  'Appointment Type:',
                                  bookingData['appointmentType']??'N/A'),
                              _buildBookingDetailRow(
                                  'Contact Info:', bookingData['contactInfo']??'N/A'),
                              _buildBookingDetailRow(
                                  'Reason for Visit:',
                                  bookingData['reasonForVisit']??'N/A'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Image.asset(
                  //   'assets/images/pet.jpg',
                  //   height: 200.0,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookingDetailRow(String label, String? value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
            value ?? '',
            style: TextStyle(
            fontSize: 18.0,
          ),
          ),
        ),
      ],
    ),
  );
  }
}
