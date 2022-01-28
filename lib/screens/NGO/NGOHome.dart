import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/screens/NGO/NGODonate.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:food_waste_management/widgets/NGO/HistoryWidget.dart';
import 'package:food_waste_management/widgets/NGO/ListRestaurant.dart';
import 'package:food_waste_management/widgets/Restaurant/drawer.dart';
import 'package:provider/provider.dart';

class NGOHome extends StatefulWidget {
  @override
  _NGOHome createState() => _NGOHome();
}

class _NGOHome extends State<NGOHome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NGOProvider>(context);
    final tabs = [
      ListRestaurant(),
      NGODonate(),
      HistoryWidget(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: primaryColor,
        selectedItemColor: primaryColor,
        currentIndex: selectedIndex,
        onTap: (index) async{
          await user.getPosts();
          await user.getHistory();
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