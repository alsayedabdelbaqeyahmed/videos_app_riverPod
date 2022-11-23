// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:video_payer/models/view/home/home_screen.dart';

enum RouteNames { home, explore, add, subscription, library }

class BottomNavigationBarController extends ChangeNotifier {
  int currentIndex = 0;

  List? screens = const [
    HomeScreen(),
    Scaffold(
      body: Center(child: Text('explore')),
    ),
    Scaffold(
      body: Center(child: Text('add')),
    ),
    Scaffold(
      body: Center(child: Text('subscription')),
    ),
    Scaffold(
      body: Center(child: Text('library')),
    ),
  ];

  void _showBottomSheet() {}

  void changeIndex(int index) {
    /// it is not a pages it is only a bottom used to open
    /// a bottom sheet only so it must not have its own index as the other
    /// so it can not open a pages at the screen like home ....etc
    if (RouteNames.values[index] == RouteNames.add) {
      _showBottomSheet();
    } else {
      currentIndex = index;
      print(currentIndex);
    }
    notifyListeners();
  }
}
