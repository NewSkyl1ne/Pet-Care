import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pet_care/ZOne/homescreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MapScreen extends StatefulWidget {

  @override


  _MapScreenState createState() => _MapScreenState();
}


Future<void> _requestLocationPermission() async {
  final status = await Permission.location.request();
  if (status.isGranted) {
    // Permission granted, do something here
    print('Location permission granted!');
    const message = 'heloooooooo';
    Fluttertoast.showToast(msg: message,fontSize: 14);

  } else {
    // Permission denied, show error message
    const message = 'noooooooo';
    Fluttertoast.showToast(msg: message,fontSize: 14);
    print('Location permission denied!');
  }
}


class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  late StreamSubscription<Position> _positionStream;
  LatLng _initialCameraPosition = LatLng(28.7041, 77.1025);
  LatLng marker1 = LatLng(28.7041, 77.3025);
  Set<Marker> _markers = {};

  @override
  void initState() {

    _requestLocationPermission();

    _positionStream = Geolocator.getPositionStream(
      // desiredAccuracy: LocationAccuracy.high,
      // distanceFilter: 10,
    ).listen((position) {
      setState(() {
        _initialCameraPosition = LatLng(position.latitude, position.longitude);

        _markers.add(
            Marker(
                markerId: MarkerId("marker_location"),
                position: marker1,
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(title: "Marker Location")
            )
        );
        _markers.add(
            Marker(
                markerId: MarkerId("marker2"),
                position: LatLng(28.5041, 77.1025),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                infoWindow: InfoWindow(title: "Marker 2")
            )
        );
        _markers.add(
            Marker(
                markerId: MarkerId("marker1"),
                position: LatLng(28.1041, 77.1025),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(title: "Marker 1")
            )
        );



      });
      _controller.animateCamera(CameraUpdate.newLatLng(_initialCameraPosition));
    });
  }
  int _selectedIndex = 1; // initialize the selected index to 0

  @override
  Widget build(BuildContext context) {
    ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.green[700],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Pet Care'),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          _controller = controller;
        },
        markers: _markers,
      ),

        bottomNavigationBar: GNav(
            selectedIndex: _selectedIndex,
            gap: 8,
            activeColor: Colors.deepOrange,

            onTabChange: (index){
              // print(index);

              setState(() {
                _selectedIndex = index; // update the selected index
              });
              // navigate to different pages based on the selected index
              switch (index) {
                case 0:
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
                  break;
                case 1:
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
                  break;
                case 2:
                // Navigator.push(context, MaterialPageRoute(builder: (_) => MapScreen()));
                  break;
                case 3:
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => InformationPage()));
                  break;
              }

            },
            // activeColor: Colors.deepOrange,
            // tabBackgroundColor: Colors.purpleAccent,
            tabs: [
              GButton(icon: Icons.home,
                text: 'Home',
              ),
              GButton(icon: Icons.search,
                text: 'Search',
              ),
              GButton(icon: Icons.settings,
                text: 'Settings',

              ),
              GButton(icon: Icons.pets,
                text: 'pets',
              ),



            ]

        )


    );
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }
}
