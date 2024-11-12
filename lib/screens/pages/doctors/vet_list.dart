import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_care/screens/pages/doctors/vet_form.dart';
import 'package:pet_care/screens/pages/doctors/vet_detail.dart';
import 'package:pet_care/screens/pages/doctors/edit_vet_form.dart';

class VetList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veterinarians'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('available_veterinarians').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          final vets = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'name': data['name'],
              'specialization': data['specialization'],
              'phone': data['phone'],
              'email': data['email'],
              'location': data['location'],
              'availableDays': data['availableDays']?.cast<String>(),
              'availableHours': data['availableHours']?.cast<String>(),
            };
          }).toList();

          return ListView.builder(
            itemCount: vets.length,
            itemBuilder: (context, index) {
              return ListTile(
              title: Text(vets[index]['name']),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vets[index]['specialization'] ?? 'N/A'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16),
                        SizedBox(width: 5),
                        Text(vets[index]['phone'] ?? 'N/A'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.email, size: 16),
                        SizedBox(width: 5),
                        Text(vets[index]['email'] ?? 'N/A'),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVetForm(vet: vets[index]),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Deletion'),
                              content: Text('Are you sure you want to delete this veterinarian?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () {
                                    FirebaseFirestore.instance.collection('available_veterinarians').doc(vets[index]['id']).delete();
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
                    MaterialPageRoute(
                      builder: (context) => VetDetails(vet: vets[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVetForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
