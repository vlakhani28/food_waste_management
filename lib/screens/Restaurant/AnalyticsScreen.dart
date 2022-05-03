import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/Restaurant/DailyData.dart';
import 'package:food_waste_management/screens/Restaurant/RestaurantHome.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'BuildChart.dart';

class AnalyticsScreen extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _AnalyticsScreen createState() => _AnalyticsScreen();
}

class _AnalyticsScreen extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    String filePath,prepare;
    if(user.user.uid == "J1iEy5hnjdUc6k9wXKhz3unDxO63") {
      filePath = "_admin";
      prepare = "52.43";
    }
    if(user.user.uid == "Oe8ooFrT6EVbbIV4S2zl33VdhSy1") {
      filePath = "_localhost";
      prepare = "105.3";
    }
    if(user.user.uid == "qHaZTyeObGR7CRjxQy7VZ2kOwVG2") {
      filePath = "_vlakhani28";
      prepare = "32.34";
    }
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("Analytics Screen",
          style: kTextFieldTextStyle.copyWith(fontSize: 25),),
        actions: <Widget>[Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                FirebaseFirestore.instance.collection("restaurant").doc(
                    user.user.uid).update({"analytics": "No"});
                return Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnalyticsScreen(),
                  ),
                );
              },
              child: Icon(
                  Icons.exit_to_app_rounded
              ),
            )
        ),
        ],
        leading: BackButton(onPressed: () {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantHome(),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          onPressed: (){
            return Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DailyData(),),
            );}),
      body: Container(
          decoration: BoxDecoration(color: Color(0xfff5f3f4)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder(
                stream: widget._firestore.collection("restaurant").doc(
                    user.user.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data["analytics"].toString() == "No") {
                    return Scaffold(
                        backgroundColor: Colors.white,
                        body: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/no_posts.png'),
                                height: 300,
                                width: 300,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'You did not apply for analytics!',
                                style: kTitleStyle.copyWith(
                                    fontSize: 30.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 20.0),
                              TextButton(
                                  child: Text(
                                    "Apply here!",
                                    style: kLabelStyle.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18.0),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance.collection(
                                        "restaurant").doc(user.user.uid).update(
                                        {"analytics": "Yes"});
                                    return Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AnalyticsScreen(),
                                      ),
                                    );
                                  }
                              )
                            ],
                          ),
                        ));
                  }
                  else {
                    return Scaffold(
                        backgroundColor: Colors.white,
                        body: BuildChart(),
                        // body:  Padding(
                        //   padding: EdgeInsets.all(8),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text('Prepare food : '+prepare+' kgs today', style: kTitleStyle.copyWith(color: primaryColor)),
                        //       SizedBox(height: 40,),
                        //       Text('Food Predicted (last 10 days)', style: kTitleStyle.copyWith(color: primaryColor)),
                        //       SizedBox(height: 20,),
                        //       Image(
                        //         image: AssetImage('assets/images/food_prepared'+filePath+'.png'),
                        //       ),
                        //       SizedBox(height: 40,),
                        //       Text('Food Left (last 10 days)', style: kTitleStyle.copyWith(color: primaryColor)),
                        //       SizedBox(height: 20,),
                        //       Image(
                        //         image: AssetImage('assets/images/food_left'+filePath+'.png'),
                        //       ),
                        //     ],
                        //   ),
                        // )
                  );
                  }
                }),
          )
      ),
    );
  }
}