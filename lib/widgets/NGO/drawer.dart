import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/screens/LoginScreen.dart';
import 'package:food_waste_management/widgets/NGO/CurrentOrders.dart';
import 'package:provider/provider.dart';
import 'package:food_waste_management/screens/ResetPasswordScreen.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'MyPosts.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NGOProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Image.asset(
                "assets/images/logo.png",
              ),
              currentAccountPictureSize: const Size.square(80.0),
              accountName: Text(user.userModel.name,
                style: kTitleStyle.copyWith(color: black),
              ),
              accountEmail: Text(user.userModel.email,
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
                Icons.all_inbox_rounded,
                color: primaryColor,
              ),
              title: Text('My Posts',
                  style: kTitleStyle.copyWith(color: primaryColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListWidget(),
                    ),
                  );
                },
            ),
            ListTile(
              leading: Icon(
                Icons.all_inclusive_rounded ,
                color: primaryColor,
              ),
              title: Text('Ongoing Orders ',
                  style: kTitleStyle.copyWith(color: primaryColor)),
              onTap: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CurrentOrders(),
                  ),
                );
              },
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
