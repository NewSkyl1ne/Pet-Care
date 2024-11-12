import 'package:flutter/material.dart';
// import 'package:travel_app/components/card_rec.dart';
// import 'package:travel_app/models/destination.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/ZOne/map.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/pages/schedule/schedule.dart';
import '../screens/pages/shopping/shopping.dart';
import 'homescreen.dart';
import 'information.dart';


// Colors
var accent = const Color(0xFF18A5FD);
var accentLight = const Color(0xFF66ACE9);
var heading = const Color(0xFF0F1641);
var text = const Color(0xFFAAAAAA);
var icon = const Color(0xFFB8BCCB);
var background = const Color(0xFFF8FAFB);
var white = const Color(0xFFFFFFFF);
var black = const Color(0xFF000000);

// TextStyles
TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w600, color: heading);
TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w600, color: heading);
TextStyle heading3 = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w600, color: heading);
TextStyle heading4 = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w600,
    color: heading);

TextStyle pBold = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.w700, color: white);
TextStyle p1 =
GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: text);
TextStyle p2 =
GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: text);
TextStyle p3 =
GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400, color: text);

TextStyle pPrice = GoogleFonts.poppins(
    fontSize: 16, fontWeight: FontWeight.w600, color: white);

TextStyle pLocation = GoogleFonts.poppins(
    fontSize: 10, fontWeight: FontWeight.w400, color: white);




class CardRecommended extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String location;

  const CardRecommended({
    required this.image,
    required this.name,
    required this.price,
    required this.location,
    super.key,
  });
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: black,
        borderRadius: BorderRadius.circular(26),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      height: 250,
      width: 200,
      margin: EdgeInsets.only(right: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(0, 0, 0, 0.75),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(13.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: accentLight,
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     width: 68,
                  //     height: 36,
                  //     // child: Center(
                  //     //   child: Text('\$$price', style: pPrice),
                  //     // ),
                  //   ),
                  // ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: pBold),
                  Text(location, style: pLocation),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}














class Destination {
  final String image;
  final String name;
  final String price;
  final String location;

  Destination(this.image, this.name, this.price, this.location);
}




class LabelSection extends StatelessWidget {
  final String text;
  final TextStyle style;

  const LabelSection({
    required this.text,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: style),
        Icon(Icons.pets, color: icon, size: 28),
      ],
    );
  }
}

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations = [
      Destination('assets/images/square-1.png', 'Vet Consulting', '120', 'Description1'),
      Destination('assets/images/square-31.png', 'Nearby', '80', 'Description2'),
      Destination('assets/images/square-4.png', 'Blog Centre ', '80', 'Description3'),
    ];

    List<void Function()> onTapFunctions = [
          () {
        // Function to be called when the first image is tapped
        print('First image tapped!');
      },
          () {
        // Function to be called when the second image is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapScreen()),
            );      },
          () {
        // Function to be called when the third image is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformationPage()),
            );
      },
    ];




    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: destinations.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var dest = destinations[index];

          return InkWell(
            onTap: onTapFunctions[index],

            child: CardRecommended(
                image: dest.image,
                name: dest.name,
                price: dest.price,
                location: dest.location),
          );
        },
      ),
    );
  }


}








///////////////////////Dog SHOP

class Top extends StatelessWidget {
  const Top({super.key});

  @override
  Widget build(BuildContext context) {
    List<Destination> destinations = [
      Destination('assets/images/square-2.png', 'Food', '120', 'desc1'),
      Destination('assets/images/download-removebg-preview.png', 'Grooming', '100', 'desc2'),
      Destination('assets/images/veterinarian.png', 'Health', '80', 'desc3'),
    ];

    List<void Function()> onTapFunctions = [
          () {
        // Function to be called when the first image is tapped
        // print('First small image tapped!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PetShoppingList()),
        );
      },
          () {
        // Function to be called when the second image is tapped
            print('Second image tapped!');

            //     Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => PetShoppingList()),
            // );
            },
          () {
        // Function to be called when the third image is tapped
            print('Third image tapped!');

            // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => MainScreen()),
        // );
      },
    ];




    return SizedBox(
      height: 105,
      child: ListView.builder(
        itemCount: destinations.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var dest = destinations[index];


          return InkWell(
            onTap: onTapFunctions[index],

            child: CardTop(
                name: dest.name, image: dest.image, location: dest.location),
          );
        },
      ),
    );
  }
}
var medium = 30.0;
var small = 16.0;
var xsmall = 10.0;

class CardTop extends StatelessWidget {
  final String name;
  final String image;
  final String location;

  const CardTop({
    required this.name,
    required this.image,
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = Colors.black; // Define the desired text color here

    final TextStyle nameStyle = GoogleFonts.poppins(
      // color: textColor,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Color(0xFF0F1641),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );


    final TextStyle locationStyle = TextStyle(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black12
            : Colors.white,
        // color: Colors.white54, // change the color here
        // color: white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 75,
      width: 186,
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Container(
            decoration: BoxDecoration(
              color: white,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(image),
                )),
            height: 69,
            width: 69,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: nameStyle),
              Text(location, style: p3),
            ],
          )
        ],
      ),
    );
  }
}
