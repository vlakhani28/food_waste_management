import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/Restaurant/RegisterScreenRestaurant.dart';
import 'package:food_waste_management/screens/NGO/RegisterScreenNGO.dart';
import 'package:food_waste_management/utilities/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        key: _key,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 80.0,
                ),
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Choose Your Role',
                          style: kTitleStyle.copyWith(
                              fontSize: 30.0, color: primaryColor),
                        ),
                      ),
                      SizedBox(height: 80.0),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                builder: (_) => RegisterScreenRestaurant(),
                            )
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            padding: EdgeInsets.all(10.0),
                            color: backgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset('assets/images/food.png',height: 80,width: 80,),
                                      ],
                                    ),
                                    SizedBox(width: 25,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(0.0),
                                                child: Text(
                                                  'Gift Food',
                                                  style: kTitleStyle.copyWith(fontSize: 30.0,color: primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Spread happiness by gifting food to needy and unfortunate',
                                                  style: kTitleStyle.copyWith(fontSize: 13.0,color: black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80.0),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterScreenNGO(),
                                )
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            padding: EdgeInsets.all(10.0),
                            color: backgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset('assets/images/ngo.png',height: 80,width: 80,),
                                      ],
                                    ),
                                    SizedBox(width: 25,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(0.0),
                                                child: Text(
                                                  'NGO',
                                                  style: kTitleStyle.copyWith(fontSize: 30.0,color: primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Be a helping hand in a mission to evacuate hunger',
                                                  style: kTitleStyle.copyWith(fontSize: 13.0,color: black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],

        )
    ),
    );
  }
}
