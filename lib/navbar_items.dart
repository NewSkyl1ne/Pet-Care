import 'package:flutter/material.dart';

List<BottomNavigationBarItem> bottomNavBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.map),
    activeIcon: Icon(Icons.map_outlined),
    label: 'Map',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    activeIcon: Icon(Icons.calendar_today_outlined),
    label: 'Booking',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    activeIcon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_cart),
    activeIcon: Icon(Icons.shopping_cart_outlined),
    label: 'Shop',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    activeIcon: Icon(Icons.person_outline),
    label: 'Profile',
  ),
];
