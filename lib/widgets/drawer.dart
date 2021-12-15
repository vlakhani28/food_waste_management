import 'package:flutter/material.dart';
import 'package:food_waste_management/screens/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/Restaurant/LoginScreenRestaurant.dart';
import 'package:food_waste_management/screens/ResetPasswordScreen.dart';
import 'package:food_waste_management/utilities/constants.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset(
                "assets/images/logo.png",
                height: 100,
                width: 100  ,
              ),
              accountName: Text('John Doe',
               // user.userModel.name,
                style: kTitleStyle.copyWith(color: black),
              ),
              accountEmail: Text('admin@gmail.com',
                //user.userModel.email,
                style: kSubTitleStyle.copyWith(fontSize: 18.0),
              ),
              decoration: BoxDecoration(color: white),
            ),
            ListTile(
              leading: Icon(
                Icons.edit,
                color: primaryColor,
              ),
              title: Text('Edit Profile',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: primaryColor,
              ),
              title: Text('Change Password',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResetPasswordScreen('Reset Password'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback_rounded ,
                color: primaryColor,
              ),
              title: Text('Feedback',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.rate_review_rounded,
                color: primaryColor,
              ),
              title: Text('Rate Us',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.article_rounded,
                color: primaryColor,
              ),
              title: Text('About Us',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(color: labelColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: labelColor,
                ),
                title: Text('Sign Out',
                    style: kTitleStyle.copyWith(color: labelColor)),
                onTap: () {
                  user.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}