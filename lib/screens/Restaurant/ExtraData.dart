import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:uuid/uuid.dart';

import '../LoginScreen.dart';

class ExtraData extends StatefulWidget {
  @override
  _ExtraData createState() => _ExtraData();
}

class _ExtraData extends State<ExtraData> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _refillInterval = TextEditingController();
  TextEditingController _workingHours = TextEditingController();
  var _stars;
  var _type;
  var _area;

  Widget _buildRegisterBtn(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    var uuid = Uuid();
    var id = uuid.v4();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: ElevatedButton(
          child: Text(
            'Submit',
            style: kTitleStyle,
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              primary: primaryColor,
              padding: EdgeInsets.all(10.0)),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              {
                if (!await user.addAnalData(
                    int.parse(_stars),
                    _area,
                    int.parse(_workingHours.text),
                    _type,
                    int.parse(_refillInterval.text),
                    id,
                    )) {
                  return null;
                } else {
                  return Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  );
                }
              }
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        key: _key,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          // child: user.status == Status.Authenticating
          //     ? Loading()
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
                          vertical: 80.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Extra Information',
                                  style: kTitleStyle.copyWith(
                                      fontSize: 30.0, color: primaryColor),
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text('Stars', style: kLabelStyle),
                              SizedBox(height: 10.0),
                              Container(
                                  decoration: kBoxDecorationStyle,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter stars of restaurant",
                                      hintStyle: kPlaceHolderStyle,
                                      prefixIcon: Icon(
                                        Icons.star_border_purple500_rounded,
                                        color: labelColor,
                                      ),
                                    ),
                                    value: _stars,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _stars = newValue;
                                      });
                                    },
                                    items: ["1", "2", "3","4","5"]
                                        .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                        .toList(),
                                  )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Area',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                  decoration: kBoxDecorationStyle,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter restaurant area (locality)",
                                      hintStyle: kPlaceHolderStyle,
                                      prefixIcon: Icon(
                                        Icons.near_me_disabled_rounded,
                                        color: labelColor,
                                      ),
                                    ),
                                    value: _area,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _area = newValue;
                                      });
                                    },
                                    items: ["Intermediate", "Crowded", "Posh"]
                                        .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                        .toList(),
                                  )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Working Hours',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _workingHours,
                                  keyboardType: TextInputType.number,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter working hours",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.lock_clock_rounded,
                                      color: labelColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text('Refill Interval', style: kLabelStyle),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _refillInterval,
                                  keyboardType: TextInputType.number,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter refill interval (in days)",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.refresh_rounded,
                                      color: labelColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Type of food',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                  decoration: kBoxDecorationStyle,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter type of food",
                                      hintStyle: kPlaceHolderStyle,
                                      prefixIcon: Icon(
                                        Icons.food_bank_rounded,
                                        color: labelColor,
                                      ),
                                    ),
                                    value: _type,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _type = newValue;
                                      });
                                    },
                                    items: ["Multicuisine", "Fastfood"]
                                        .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                        .toList(),
                                  )
                              ),
                              SizedBox(height: 10.0),
                              _buildRegisterBtn(context),
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
