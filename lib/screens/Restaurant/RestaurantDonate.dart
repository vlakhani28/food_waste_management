import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/utilities/constants.dart';

class RestaurantDonate extends StatefulWidget {
  @override
  _RestaurantDonateState createState() => _RestaurantDonateState();
}

class _RestaurantDonateState extends State<RestaurantDonate> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  var _pickupDay;
  var _veg;
  TextEditingController _cookedBefore = TextEditingController();
  var _withContainer;
  var _mealType;

  Widget _buildPopUpDialog(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          contentPadding: EdgeInsets.all(25.0),
          buttonPadding: EdgeInsets.symmetric(horizontal:35.0),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/screen1.png',width: 200,),
              SizedBox(height: 10.0,),
              Text(
                'Donation Request Sent',
                style: kLabelStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(height: 10.0,),
              Text(
                'Thank you for gifting food',
                style: kLabelStyle.copyWith(fontSize: 15.0,color: Colors.black),
              ),
              Text(
                'World has less people hungry today',
                style: kLabelStyle.copyWith(fontSize: 15.0,color: Colors.black),
              ),
              Text(
                'Because of YOU!',
                style: kLabelStyle.copyWith(fontSize: 15.0,fontWeight:FontWeight.bold,color: Colors.black),
              )
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
                      //Do Something
                      // if (_formKey.currentState.validate()) {
                      //   {
                      //     if (!await user.signUp(
                      //         _name.text,
                      //         _email.text,
                      //         _confirmPassword.text,
                      //         _address.text,
                      //         _mobileNumber.text,
                      //         context)) {
                      //       return null;
                      //     } else {
                      //       return Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (_) => LoginScreen(),
                      //         ),
                      //       );
                      //     }
                      //   }
                      // }
                    }),
              ],
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildSubmitBtn(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
          child: Text(
            'SUBMIT',
            style: kTitleStyle,
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              primary: primaryColor,
              padding: EdgeInsets.all(10.0)),
          onPressed: () async {
            showDialog(context: context, builder: (BuildContext context) => _buildPopUpDialog(context),);
          }),
    );
  }


  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Create Post',
          style: kTitleStyle.copyWith(
              fontSize: 25.0, color: primaryColor),
        ),
        leading:IconButton(
        icon: Icon(Icons.keyboard_arrow_left_rounded , color: Colors.black,size: 30.0,),
        onPressed: () => Navigator.of(context).pop(),
      ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        key: _key,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                          horizontal: 30.0,
                          vertical: 30.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Dish Name', style: kLabelStyle),
                              SizedBox(height: 10.0),
                              Container(
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
                              SizedBox(height: 10.0),
                              Text(
                                'Quantity (Number of People)',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _quantity,
                                  keyboardType: TextInputType.emailAddress,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter number of quantity",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.people_outline_rounded,
                                      color: labelColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Meal Type',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter your meal type",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.set_meal_rounded,
                                      color: labelColor,
                                    ),
                                  ),
                                  value: _mealType,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _mealType = newValue;
                                    });
                                  },
                                  items: ["Breakfast", "Lunch", "Dinner"]
                                      .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                                      .toList(),
                                )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Veg or Non Veg',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                  decoration: kBoxDecorationStyle,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your meal type",
                                      hintStyle: kPlaceHolderStyle,
                                      prefixIcon: Icon(
                                        Icons.fastfood_rounded,
                                        color: labelColor,
                                      ),
                                    ),
                                    value: _veg,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _veg = newValue;
                                      });
                                    },
                                    items: ["Veg", "Non Veg"]
                                        .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                        .toList(),
                                  )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Cooked Before (Number of Hours)',
                                style: kLabelStyle,
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
                              SizedBox(height: 10.0),
                              Text(
                                'With Container?',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
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
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Pickup Day',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                  decoration: kBoxDecorationStyle,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter your pickup day",
                                      hintStyle: kPlaceHolderStyle,
                                      prefixIcon: Icon(
                                        Icons.wb_sunny_rounded,
                                        color: labelColor,
                                      ),
                                    ),
                                    value: _pickupDay,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _pickupDay = newValue;
                                      });
                                    },
                                    items: ["Today", "Tomorrow"]
                                        .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                        .toList(),
                                  )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Pickup Time',
                                style: kLabelStyle,
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
                              SizedBox(height: 15.0),
                              _buildSubmitBtn(context),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
