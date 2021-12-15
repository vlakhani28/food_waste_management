import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:food_waste_management/widgets/drawer.dart';
import 'package:provider/provider.dart';

class RestaurantHome extends StatefulWidget {
  @override
  _RestaurantHome createState() => _RestaurantHome();
}

class _RestaurantHome extends State<RestaurantHome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<RestaurantProvider>(context);
    // final name = user.userModel.name;
    final tabs = [
      //ListWidget(),
      Container(),
      //History()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 0.0,
        title: Text('Hello,',style: kTitleStyle.copyWith(fontSize: 20.0,color: Colors.black)),
        centerTitle: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: primaryColor,
        selectedItemColor: primaryColor,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
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
      body: tabs[selectedIndex],
      endDrawer: CustomDrawer(),
    );
  }
}