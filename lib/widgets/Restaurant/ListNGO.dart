import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_waste_management/providers/NGO/NGOLoginProvider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/screens/Restaurant/RestaurantHome.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:provider/provider.dart';
import '../CustomSnackBar.dart';
import 'drawer.dart';

class ListNGO extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _ListNGOState createState() => _ListNGOState();
}

class _ListNGOState extends State<ListNGO> {
  @override
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
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
        body:NGOList(),
    );
  }
}

class NGOList extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color(0xfff5f3f4)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("NGO").snapshots(),
              builder: (context,snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                }
                List<DocumentSnapshot> documents = snapshot.data.docs;
                return ListV(documents: documents);
              }),
        )
    );
  }
}

class ListV extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  ListV({this.documents});

  List<Widget> _getChildren() {
    List<Widget> children = [];
    documents.forEach((doc) {
      children.add(
        CardItem(
          name: doc['name'],
          projectKey: doc.id,
          firestore: firestore,
          uin: doc['uin'],
          id: doc['id']
        ),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getChildren(),
    );
  }
}



class CardItem extends StatelessWidget {
  CardItem(
      { this.projectKey,  this.name,  this.firestore, this.uin, this.id});

  final String projectKey;
  final String name;
  final String uin;
  final String id;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    PageStorageKey _projectKey = PageStorageKey('$projectKey');

    return Column(
      key: _projectKey,
      children: <Widget>[
        StreamBuilder(
            stream: firestore
                .collection('NGO')
                .doc(projectKey)
                .collection('posts')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              List<DocumentSnapshot> documents = snapshot.data.docs;

              List<Widget> allPosts = [];
              documents.forEach((doc) {
                PageStorageKey _surveyKey = new PageStorageKey('${doc.id}');
                allPosts.add(
                    CreateCard(
                      name:name,
                     mealType: doc["mealType"],
                      quantity: doc["quantity"],
                      pickUpDay: doc["pickUpDay"],
                      veg: doc["veg"],
                      id: doc["id"],
                      uin: uin,
                      ngoId:id,
                      postId:doc["id"]
                ));
              });
              return Column(children: allPosts);
            })
      ],
    );
  }
}

class CreateCard extends StatelessWidget {
  CreateCard({ this.name, this.mealType,  this.pickUpDay,  this.quantity,this.veg, this.id, this.uin,this.ngoId,this.postId});

  final String mealType;
  final String name;
  final String pickUpDay;
  final String veg;
  final int quantity;
  final String id;
  final String uin;
  final String ngoId;
  final String postId;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    final user1 = Provider.of<NGOProvider>(context);
    return Card(
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
                    name,
                    style: kTitleStyle.copyWith(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    quantity.toString() + " servings needed",
                    style: kTitleStyle.copyWith(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.w400),
                  )
                ],
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/images/food_1.png",height: 20,),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        veg,
                        style: kTitleStyle.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/location.png",height: 20,),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        pickUpDay,
                        style: kTitleStyle.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/eat.png",height: 20,),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        mealType,
                        style: kTitleStyle.copyWith(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 45,
                width: 300,
                child: ElevatedButton(
                    child: Text(
                      'Donate',
                      style: kTitleStyle.copyWith(fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        primary: primaryColor,
                        padding: EdgeInsets.all(10.0)),
                    onPressed: (){
                      showDialog(context: context, builder: (BuildContext context) => _buildPopUp(context),);
                    }
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildPopUp(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _cookedBefore = TextEditingController();
    var _withContainer;
    final user = Provider.of<RestaurantProvider>(context);
    final user1 = Provider.of<NGOProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AlertDialog(
          contentPadding: EdgeInsets.all(25.0),
          buttonPadding: EdgeInsets.symmetric(horizontal:35.0),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dish Name', style: kLabelStyle.copyWith(fontSize: 18.0)),
              SizedBox(height: 10.0),
              Container(
                width: 800,
                decoration: kBoxDecorationStyle,
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  style: kTextFieldTextStyle.copyWith(
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Dal and Rice",
                    hintStyle: kPlaceHolderStyle,
                    prefixIcon: Icon(
                      Icons.food_bank_rounded,
                      color: labelColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Cooked Before (Hours)',
                style: kLabelStyle.copyWith(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: kBoxDecorationStyle,
                child: TextFormField(
                  controller: _cookedBefore,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.phone,
                  style: kTextFieldTextStyle.copyWith(
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Cooked Before",
                    hintStyle: kPlaceHolderStyle,
                    prefixIcon: Icon(
                      Icons.access_alarm_rounded,
                      color: labelColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'With Container?',
                style: kLabelStyle.copyWith(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              StatefulBuilder(builder:
                  (BuildContext context,
                  StateSetter setState) {
                return Container(
                    decoration: kBoxDecorationStyle,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your choice",
                        hintStyle: kPlaceHolderStyle,
                        prefixIcon: Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: labelColor,
                        ),
                      ),
                      value: _withContainer,
                      onChanged: (String newValue) {
                        setState(() {
                          _withContainer = newValue;
                        });
                      },
                      items: ["Yes", "No"]
                          .map((label) => DropdownMenuItem(
                        child: Text(label.toString()),
                        value: label,
                      ))
                          .toList(),
                    )
                );
              }),
            ],
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    child: Text(
                      'OKAY',
                      style: kTitleStyle,
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        primary: primaryColor,
                        padding: EdgeInsets.all(10.0)),
                    onPressed: () {
                      user.addOnGoing(DateTime.now(), _name.text, id, quantity, veg, int.parse(_cookedBefore.text), _withContainer, pickUpDay, mealType, name, uin,ngoId,user.userModel.id);
                      user1.addOnGoing(DateTime.now(), _name.text, id, quantity, veg, int.parse(_cookedBefore.text), _withContainer, pickUpDay, mealType, user.userModel.mobileNumber,user.userModel.name,user.userModel.id,ngoId);
                      user1.removePost(postId, ngoId);
                      return Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantHome(),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ],
    );
  }

}




