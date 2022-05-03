import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_waste_management/widgets/CustomSnackBar.dart';
import 'package:provider/provider.dart';
import 'package:food_waste_management/providers/Restaurant/RestaurantLoginProvider.dart';
import 'package:food_waste_management/utilities/constants.dart';
import 'package:uuid/uuid.dart';
import 'AnalyticsScreen.dart';
import 'RestaurantHome.dart';

class DailyData extends StatefulWidget {
  @override
  _DailyData createState() => _DailyData();
}

class _DailyData extends State<DailyData> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _food_prepared = TextEditingController();
  TextEditingController _food_leftover = TextEditingController();
  var _bankHoliday;
  TextEditingController _food_ordered = TextEditingController();
  TextEditingController _no_of_people = TextEditingController();
  var _weekday;
  Widget _buildSubmitBtn(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    var uuid = Uuid();
    var id = uuid.v4();
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
            if (_formKey.currentState.validate()) {
              {
                if (await user.addAnalDataDaily(
                    double.parse(_food_prepared.text),
                    double.parse(_food_prepared.text) - double.parse(_food_ordered.text),
                    int.parse(DateTime.now().weekday.toString()),
                    int.parse(_bankHoliday),
                    double.parse(_food_ordered.text),
                    int.parse(_no_of_people.text),
                    id
                )) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnalyticsScreen(),
                    ),
                  );
                } else {
                  return CustomSnackbar(message: "Cannot add data");
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
      appBar: AppBar(
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Add Daily Data',
          style: kTitleStyle.copyWith(
              fontSize: 25.0, color: primaryColor),
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
                              Text('Food Quantity Prepared (kgs)', style: kLabelStyle),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _food_prepared,
                                  keyboardType: TextInputType.number,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "5",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.restaurant,
                                      color: labelColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Bank Holiday',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "1 = Yes, 0 = No",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.access_time_filled_rounded,
                                      color: labelColor,
                                    ),
                                  ),
                                  value: _bankHoliday,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _bankHoliday = newValue;
                                    });
                                  },
                                  items: ["1", "0"]
                                      .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                                      .toList(),
                                )
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Food Ordered (kgs)',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _food_ordered,
                                  keyboardType: TextInputType.phone,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "25",
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
                                'No. of people visited today',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                decoration: kBoxDecorationStyle,
                                child: TextFormField(
                                  controller: _no_of_people,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  keyboardType: TextInputType.phone,
                                  style: kTextFieldTextStyle.copyWith(
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "No. of people",
                                    hintStyle: kPlaceHolderStyle,
                                    prefixIcon: Icon(
                                      Icons.people_rounded,
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
