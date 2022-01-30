import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/NGO/NGOHome.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';

class CurrentOrders extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NGOProvider>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("OnGoing Orders",style: kTextFieldTextStyle.copyWith(fontSize: 25),),
        leading: BackButton(onPressed:(){return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => NGOHome(),
          ),
        );}),
      ),
      body: Container(
          decoration: BoxDecoration(color: Color(0xfff5f3f4)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: widget._firestore.collection("NGO/"+user.user.uid+"/onGoing").snapshots(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        int cookedBefore = snapshot.data.docs[index]["cookedBefore"];
                        String dishName = snapshot.data.docs[index]["dishName"];
                        String tId = snapshot.data.docs[index]["id"];
                        String restName = snapshot.data.docs[index]["restName"];
                        String mobileNumber = snapshot.data.docs[index]["restNumber"];
                        Timestamp orderPlaced = snapshot.data.docs[index]["orderPlaced"];
                        String pickUpDay = snapshot.data.docs[index]["pickUpDay"];
                        int quantity = snapshot.data.docs[index]["quantity"];
                        String mealType = snapshot.data.docs[index]["mealType"];
                        String restId = snapshot.data.docs[index]["restId"];
                        return CardItem(cookedBefore: cookedBefore,dishName: dishName,tId: tId,restName: restName,mobileNumber: mobileNumber,orderPlaced: orderPlaced,
                        pickUpDay: pickUpDay,quantity: quantity,mealType: mealType,restId:restId
                        );
                      }
                  );
                }),
          )
      ),
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
      {Key key, this.cookedBefore, this.quantity, this.mealType, this.dishName, this.tId, this.restName, this.restId, this.mobileNumber, this.orderPlaced, this.pickUpDay,this.veg, this.withContainer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    final user1 = Provider.of<NGOProvider>(context);
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
                      Icon(Icons.fastfood_rounded, color: black),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        restName,
                        style: kTitleStyle.copyWith(color: primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.people_rounded, color: black),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        quantity.toString() + " servings",
                        style: kTitleStyle.copyWith(color: primaryColor,fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(Icons.set_meal, color: black),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        mealType,
                        style: kTitleStyle.copyWith(color: primaryColor,fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  //Order Delivered Button
                  // SizedBox(
                  //   height: 45,
                  //   width: 300,
                  //   child: ElevatedButton(
                  //       child: Text(
                  //         'Order Delivered',
                  //         style: kTitleStyle.copyWith(fontWeight: FontWeight.w500),
                  //       ),
                  //       style: ElevatedButton.styleFrom(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12.0),
                  //           ),
                  //           primary: primaryColor,
                  //           padding: EdgeInsets.all(10.0)),
                  //       onPressed: (){
                  //         user.addHistory(orderPlaced, dishName, tId, quantity, veg, quantity, withContainer, pickUpDay, mealType, user1.userModel.name, user1.userModel.uin,user1.userModel.id,restId);
                  //         user1.addHistory(orderPlaced, dishName, tId, quantity, veg, quantity, withContainer, pickUpDay, mealType, mobileNumber,restName,restId,user1.userModel.id);
                  //         user.removeOnGoing(tId, restId);
                  //         user1.removeOnGoing(tId, user1.userModel.id);
                  //         return Navigator.pushReplacement(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (_) => NGOHome(),
                  //           ),
                  //         );
                  //       }
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
