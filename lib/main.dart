import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/LoginScreen.dart';
import 'package:food_waste_management/screens/NGO/NGODonate.dart';
import 'package:food_waste_management/screens/Restaurant/RestaurantDonate.dart';
import 'package:food_waste_management/screens/SplashScreen.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';

import 'model/NGO/NGOHomeModel.dart';
import 'model/Restaurant/RestaurantHomeModel.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(
      create: (context) => RestaurantProvider.initialize(),
        ),
        ChangeNotifierProvider(
          create: (context) => NGOProvider.initialize(),
        ),
    ],
          child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor));
    return MaterialApp(
      title: 'Helping Hand',
      debugShowCheckedModeBanner: false,
      home: ScreenController(),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    final user1 = Provider.of<NGOProvider>(context);
    //return NGODonate();
    if(user != null)
      {
    switch (user.status) {
      case Status.Uninitialized:
        return SplashScreen();
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return RestaurantHome();
      case Status.Unauthenticated:
        return SplashScreen();
      default:
        return LoginScreen();
      }
    }
    else if(user1 != null)
      {
        print(user1.status);
        switch (user1.status) {
          case StatusNGO.Uninitialized:
            return SplashScreen();
          case StatusNGO.Authenticating:
            return LoginScreen();
          case StatusNGO.Authenticated:
            return NGOHome();
          case StatusNGO.Unauthenticated:
            return SplashScreen();
          default:
            return LoginScreen();
        }
      }
    else
      return SplashScreen();
  }
}