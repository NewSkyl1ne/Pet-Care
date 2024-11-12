import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet_care/ZOne/map.dart';
import 'package:pet_care/ZOne/information.dart';
import 'package:flutter/services.dart';
import 'package:pet_care/ZOne/recommended.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pet_care/screens/home/home_screen.dart';
import 'package:pet_care/screens/pages/shopping/shoppingCard.dart';

import '../screens/home/home_screen1.dart';
import '../screens/pages/booking/booking_list.dart';
import '../screens/pages/dashboard/dashboard.dart';
import '../screens/pages/doctors/vet_detail.dart';
import '../screens/pages/index/home.dart';
import '../screens/pages/schedule/schedule.dart';
import '../screens/pages/shopping/shopping.dart';


TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w600);
// fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF0F1641));

TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w600, color:
Color(0xFF0F1641)
);
TextStyle heading3 = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0F1641));
TextStyle heading4 = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F1641));


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}


//class MainScreen extends StatelessWidget {
class _MainScreenState extends State<MainScreen> {

  // //Bottom navigation bar routes
  // int _selectedIndex = 0;
  // void _navigateBottomBar(int index)
  // {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  //
  // final List<Widget> _pages = [
  //   InformationPage(),
  //   InformationPage(),
  //   InformationPage(),
  // ];

  int _selectedIndex = 0; // initialize the selected index to 0






  //location permission on app homescreen
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, do something here
      print('Location permission granted!');
    } else {
      // Permission denied, show error message
      print('Location permission denied!');
    }
  }


  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // return false;
        final difference =DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning){
          // Navigator.popAndPushNamed(context,'/home_screen');
          // Navigator.of(context).pop();
          // Navigator.of(context).pushReplacementNamed('/home_screen');
          // Navigator.of(context).pushReplacement(newRoute)
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message,fontSize: 14);
          return false;
        }else{
          Fluttertoast.cancel();
          return true;

        }
      },


      child: Scaffold(
        // backgroundColor: Color(0xFFF8FAFB),
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('Pet Care'),
        //   backgroundColor: Colors.deepPurpleAccent,
        //   // elevation: 22,
        //   shadowColor: Colors.deepPurpleAccent,
        //   // leading: ,
        //   // actions: [],
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200),bottomRight: Radius.circular(00)),
        //   ),
        //
        //   bottom: PreferredSize(
        //     preferredSize: Size.fromHeight(0),
        //     child: SizedBox(),
        //   ),
        // ),


        body: SafeArea(     //safearea vs centre


          child: Padding(
            padding: EdgeInsets.only(left: 16.0, top: 0, right: 16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    // height: getVerticalSize(134.00,),
                    // width: getHorizontalSize(468.00,),
                    // margin: getMargin(
                    //   left: 20,
                    //   top: 8,
                    //   right: 20,
                    // ),

                    child: Stack(



                      alignment: Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            // width: getHorizontalSize(268.00,),
                            // margin: getMargin(bottom: 2,),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "PET CARE \n",
                                    style: GoogleFonts.poppins(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.deepOrangeAccent,
                                      fontSize: (45),
                                      // fontFamily: 'SF UI Display',
                                      fontWeight: FontWeight.w400,
                                      // fontWeight: FontWeight.w500,
                                      height: 2.12,
                                    ),
                                  ),

                                  TextSpan(
                                    text: "To give them the care \n they NEED !",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                      // fontSize: (15),
                                      // fontFamily: 'SF UI Display',
                                      fontWeight: FontWeight.w300,
                                      // fontWeight: FontWeight.w500,

                                      height: 1.32,
                                    ),
                                  ),

                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),

                        InkWell(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.0, top: 0, right: 1.0),
                              child: Image.asset(
                                'assets/images/dog2.gif',
                                width: 120,
                                height: 120,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 56.0),

                LabelSection(text: 'Pet Services', style: heading1),
                SizedBox(height: 16.0),

                const Recommended(),
                SizedBox(height: 56.0),



                LabelSection(text: 'Shop by Category',        style: GoogleFonts.poppins(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Color(0xFF0F1641),
                  fontSize: (18),
                  // fontFamily: 'GoogleFonts.poppins',
                  fontWeight: FontWeight.w600,
                  // fontWeight: FontWeight.w500,
                  height: 1.32,),),
                SizedBox(height: 16.0),
                const Top(),

              ],
            ),
          ),
        ),


        bottomNavigationBar: GNav(
            selectedIndex: _selectedIndex,
            gap: 8,
            rippleColor: Colors.grey[300]!,
            activeColor: Colors.deepOrange,
            // tabBackgroundColor: Colors.grey,
            // iconSize: 24,
            duration: Duration(milliseconds: 400),
            // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 32),

            onTabChange: (index){
              // print(index);

              setState(() {
                _selectedIndex = index; // update the selected index
              });
              // navigate to different pages based on the selected index
              switch (index) {
                case 0:
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
                  break;
                case 1:

                  Navigator.push(context, MaterialPageRoute(builder: (_) => Schedule()));
                  
                  break;
                case 2:
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                  break;
                case 3:
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PetCareDashboard()));
                  break;
              }

            },
            // tabBackgroundColor: Colors.purpleAccent,
            tabs: const [

              // GButton(icon: Icons.home,
              //   text: 'Home',
              // ),
          GButton(icon: Icons.home,
            text: 'Home',
          ),
          GButton(icon: Icons.calendar_month,
            text: 'Schedule',
          ),
          GButton(icon: Icons.person,
            text: 'Profile',

          ),
          GButton(icon: Icons.settings,
            text: 'Settings',
          ),




        ]

        )

        //
        // bottomNavigationBar: NavigationBar(
        //   currentIndex: 1,
        //   height: 94,
        //   animationDuration: const Duration(milliseconds: 1000),
        //   destinations: <Widget>[
        //     NavigationDestination(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //
        //
        //     ),
        //     NavigationDestination(
        //       icon: Icon(Icons.explore),
        //       label: 'Explore',
        //     ),
        //
        //     NavigationDestination(
        //       // icon: Icon(Icons.person),
        //       icon: Image.asset(
        //         'assets/images/user7.png',
        //         width: 24,
        //         height: 24,
        //       ),
        //       label: 'Profile',
        //     ),
        //
        //     NavigationDestination(
        //       icon: Icon(Icons.settings_rounded),
        //       label: 'Settings',
        //     ),
        //   ],
          // onDestinationSelected: (int index) {
          //   setState(() {
          //     _currentPageIndex = index;
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => InformationPage(),
          //       ),
          //     );
          //   });
          // },
          // selectedIndex: _currentPageIndex,

          //backgroundColor: Colors.blue,
          // elevation: 10,
          // surfaceTintColor: Colors.lime,
          //height: 20,
          //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // ),






      ),

    );


  }


}

