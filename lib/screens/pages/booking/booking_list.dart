import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'booking_form.dart';
import 'update_booking_form.dart';
import 'booking_detail.dart';


class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdaf2f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Bookings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBookingForm()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: _buildFilterButtons(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final bookings = snapshot.data!.docs;
                final filteredBookings = _filterBookings(bookings);
                return Padding(
                  padding: EdgeInsets.all(24),
                  child: ListView.builder(
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            booking['petName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            booking['date'],
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.grey,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditBookingForm(bookingId: booking.id)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Booking?'),
                                        content: Text('Are you sure you want to delete this booking?'),
                                        actions: [
                                          TextButton(
                                            child: Text('CANCEL'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('DELETE'),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                .collection('bookings')
                                                .doc(booking.id)
                                                .delete();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingDetailScreen(bookingId: booking.id)),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterButton('All'),
        SizedBox(width: 8),
        _buildFilterButton('Pending'),
        SizedBox(width: 8),
        _buildFilterButton('Cancelled'),
        SizedBox(width: 8),
        _buildFilterButton('Booked'),
      ],
    ),
  );
}

  Widget _buildFilterButton(String filter) {
    final isSelected = filter == selectedFilter;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      style: ButtonStyle(
        backgroundColor: isSelected ? MaterialStateProperty.all<Color>(Colors.blue) : null,
      ),
      child: Text(filter),
    );
  }

  List<DocumentSnapshot> _filterBookings(List<DocumentSnapshot> bookings) {
    if (selectedFilter == 'All') {
      return bookings;
    } else {
      return bookings.where((booking) => booking['status'] == selectedFilter).toList();
    }
  }
}
