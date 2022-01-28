import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/Restaurant/RestaurantDonate.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:food_waste_management/widgets/Restaurant/HistoryWidget.dart';
import 'package:food_waste_management/widgets/Restaurant/ListNGO.dart';
import 'package:food_waste_management/widgets/Restaurant/MyPosts.dart';
import 'package:food_waste_management/widgets/Restaurant/drawer.dart';
import 'package:provider/provider.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHome createState() => _RestaurantHome();
}

class _RestaurantHome extends State<RestaurantHome> {
  int selectedIndex = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    final tabs = [
      ListNGO(),
      RestaurantDonate(),
      HistoryWidget(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: primaryColor,
        selectedItemColor: primaryColor,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
          selectedIndex = index;
        });},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded,size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_sharp , size: 28),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history , size: 28),
            label: 'History',
          ),
        ],
      ),
      body:
      tabs[selectedIndex],
    );
  }
}