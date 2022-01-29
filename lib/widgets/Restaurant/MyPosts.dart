import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/Restaurant/RestaurantHome.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../CustomSnackBar.dart';
import 'drawer.dart';

class ListWidget extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("My Posts",style: kTextFieldTextStyle.copyWith(fontSize: 25),),
        leading: BackButton(onPressed:(){return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantHome(),
          ),
        );}),
      ),
      body: Container(
            decoration: BoxDecoration(color: Color(0xfff5f3f4)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: widget._firestore.collection("restaurant/"+user.user.uid+"/posts").snapshots(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        int quantity = snapshot.data.docs[index]["quantity"];
                        String mealType = snapshot.data.docs[index]["mealType"];
                        String name = snapshot.data.docs[index]["dishName"];
                        var id = snapshot.data.docs[index].id;
                        return CardItem(quantity: quantity,mealType: mealType,index: id,name: name);
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
  final String mealType;
  final String index;
  final String name;
  const CardItem(
      {Key key, this.quantity, this.mealType, this.index,this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context); //Change this to NGO
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
                        Icon(Icons.fastfood_rounded, color: black),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          name,
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
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
