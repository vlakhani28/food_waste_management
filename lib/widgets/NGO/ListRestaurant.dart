import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../CustomSnackBar.dart';
import '../NGO/drawer.dart';

class ListRestaurant extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ListRestaurantState createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    final user1 = Provider.of<NGOProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.white,
        elevation: 0.0,
        title: Text('Hello,',style: kTitleStyle.copyWith(fontSize: 20.0,color: Colors.black)),
        centerTitle: false,
      ),
      endDrawer: CustomDrawer(),
      body: Container(
          decoration: BoxDecoration(color: Color(0xfff5f3f4)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: widget._firestore.collection("ngo/"+user.user.uid+"/posts").snapshots(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        String veg = snapshot.data.docs[index]["veg"];
                        int quantity = snapshot.data.docs[index]["quantity"];
                        String mealType = snapshot.data.docs[index]["mealType"];
                        return CardItem(veg: veg,quantity: quantity,mealType: mealType,index: user.user.uid,);
                      }
                  );
                }),
          )
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final int quantity;
  final String veg;
  final String mealType;
  final String index;
  const CardItem(
      {Key key, this.quantity, this.veg, this.mealType, this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context); //Change this to NGO
    return Column(
      children: [
        Card(
          color: Colors.black,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                bool success = await user.removePost(index,user.userModel.id);
                if (success) {
                  user.reloadPosts();
                  CustomSnackbar.show(context, 'Post Removed');
                } else {
                  CustomSnackbar.show(context, "Post Didn't Removed");
                }
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: primaryColor),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        mealType,
                        style: kTitleStyle.copyWith(color: primaryColor),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
