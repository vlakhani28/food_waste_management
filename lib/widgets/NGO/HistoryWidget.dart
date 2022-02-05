import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../CustomSnackBar.dart';
import 'drawer.dart';

class HistoryWidget extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NGOProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 0.0,
        title: Text('Hello,' + user.userModel.name,
            style: kTitleStyle.copyWith(fontSize: 25.0, color: primaryColor)),
        centerTitle: true,
      ),
      endDrawer: CustomDrawer(),
      body: Container(
          decoration: BoxDecoration(color: Color(0xfff5f3f4)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: widget._firestore
                    .collection("NGO/" + user.user.uid + "/history")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data.docs.isEmpty) {
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
                                'No History Found',
                                style: kTitleStyle.copyWith(
                                    fontSize: 30.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                "Looks like you haven't ordered anything yet!",
                                style: kLabelStyle.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18.0),
                              )
                            ],
                          ),
                        ));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          int cookedBefore =
                              snapshot.data.docs[index]["cookedBefore"];
                          String dishName =
                              snapshot.data.docs[index]["dishName"];
                          String tId = snapshot.data.docs[index]["id"];
                          String restName =
                              snapshot.data.docs[index]["restName"];
                          String mobileNumber =
                              snapshot.data.docs[index]["restNumber"];
                          Timestamp orderPlaced =
                              snapshot.data.docs[index]["orderPlaced"];
                          String pickUpDay =
                              snapshot.data.docs[index]["pickUpDay"];
                          int quantity = snapshot.data.docs[index]["quantity"];
                          String mealType =
                              snapshot.data.docs[index]["mealType"];
                          String restId = snapshot.data.docs[index]["restId"];
                          String veg = snapshot.data.docs[index]["veg"];
                          return CardItem(
                              cookedBefore: cookedBefore,
                              dishName: dishName,
                              tId: tId,
                              restName: restName,
                              mobileNumber: mobileNumber,
                              orderPlaced: orderPlaced,
                              pickUpDay: pickUpDay,
                              quantity: quantity,
                              mealType: mealType,
                              restId: restId,
                              veg: veg);
                        });
                  }
                }),
          )),
    );
  }
}

class CardItem extends StatelessWidget {
  final int cookedBefore;
  final int quantity;
  final String dishName;
  final String mealType;
  final String tId;
  final String restName;
  final String mobileNumber;
  final Timestamp orderPlaced;
  final String pickUpDay;
  final String veg;
  final String withContainer;
  final String restId;
  const CardItem(
      {Key key,
      this.cookedBefore,
      this.quantity,
      this.mealType,
      this.dishName,
      this.tId,
      this.restName,
      this.restId,
      this.mobileNumber,
      this.orderPlaced,
      this.pickUpDay,
      this.veg,
      this.withContainer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        restName,
                        style: kTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/servings.png",
                        height: 20,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        quantity.toString() + " servings accepted",
                        style: kTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/mealName.png",
                        height: 20,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        dishName,
                        style: kTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/food_1.png",
                        height: 20,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        veg,
                        style: kTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/location.png",
                        height: 20,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                          orderPlaced.toDate().toLocal().day.toString() +"-"+ orderPlaced.toDate().toLocal().month.toString() + "-" + orderPlaced.toDate().toLocal().year.toString(),
                        style: kTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/eat.png",
                        height: 20,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        mealType,
                        style: kTitleStyle.copyWith(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
