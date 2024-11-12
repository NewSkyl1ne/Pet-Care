import 'package:flutter/material.dart';
import 'petShopList.dart';
import 'counselingList.dart';
import 'vetCenterList.dart';

class Home extends StatelessWidget {
  
  void _navigateToVetCenter(BuildContext context) {
    // Add code to navigate to Feedback screen
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Vet Center'),
        ),
        body: Center(
          child: Text('This is the Vet Center screen'),
        ),
        ),
      ),
    );
  }
  void _navigateToBlogs(BuildContext context) {
    // Add code to navigate to Feedback screen
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Blogs'),
        ),
        body: Center(
          child: Text('This is the Blogs screen'),
        ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pet Care',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
             Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      child: InkWell(
                        onTap: () => _navigateToVetCenter(context),
                        child: Icon(Icons.local_hospital, size: 35.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Find a Vet Center',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                                  InkWell(
                    onTap: () => _navigateToBlogs(context),
                    child: CircleAvatar(
                      radius: 50.0,
                      child: Icon(Icons.article, size: 35.0),
                    ),
                  ),
                    SizedBox(height: 10.0),
                    Text(
                      'Blog Center',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            VetCenterList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pets Vet Counseling',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            CounselingList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pet Shop by Category',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Center(
              child: PetShopList(),
            ),
          ],
        ),
      ),
    );
  }
}
