import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/screens/NGO/NGOHome.dart';
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
    final user = Provider.of<NGOProvider>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text(
          "My Posts",
          style: kTextFieldTextStyle.copyWith(fontSize: 25),
        ),
        leading: BackButton(onPressed: () {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => NGOHome(),
            ),
          );
        }),
      ),
      body: Container(
          decoration: BoxDecoration(color: Color(0xfff5f3f4)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: StreamBuilder<QuerySnapshot>(
                stream: widget._firestore
                    .collection("NGO/" + user.user.uid + "/posts")
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
                                'No Posts Found',
                                style: kTitleStyle.copyWith(
                                    fontSize: 30.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                "Looks like you haven't posted anything yet!",
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
                          int quantity = snapshot.data.docs[index]["quantity"];
                          String mealType =
                              snapshot.data.docs[index]["mealType"];
                          String pickUpDay =
                              snapshot.data.docs[index]["pickUpDay"];
                          String veg = snapshot.data.docs[index]["veg"];
                          var id = snapshot.data.docs[index].id;
                          return CardItem(
                              quantity: quantity,
                              mealType: mealType,
                              index: id,
                              pickUpDay: pickUpDay,
                              veg: veg);
                        });
                  }
                }),
          )),
    );
  }
}

class CardItem extends StatelessWidget {
  final int quantity;
  final String mealType;
  final String index;
  final String pickUpDay;
  final String veg;
  const CardItem(
      {Key key,
      this.quantity,
      this.mealType,
      this.index,
      this.pickUpDay,
      this.veg})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NGOProvider>(context);
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
                  bool success =
                      await user.removePost(index, user.userModel.id);
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
                          pickUpDay,
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
