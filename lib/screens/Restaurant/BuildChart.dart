import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import '../../providers/Restaurant/RestaurantLoginProvider.dart';
import '../../utilities/constants.dart';
import 'data.dart';
class BuildChart extends StatefulWidget {
  @override
  _BuildChartState createState() {
    return _BuildChartState();
  }
}


class _BuildChartState extends State<BuildChart> {
  List<charts.Series<Sales, String>> _seriesBarData = [];
  List<Sales> mydata;
  _generateData(mydata) {
    _seriesBarData = [];
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => sales.date.toDate().day.toString(),
        measureFn: (Sales sales, _) => double.parse(sales.food_prepared),
        id: 'Sales',
        data: mydata,
        labelAccessorFn: (Sales row, _) => "${row.food_prepared}",
      ),
    );
    print(_seriesBarData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final user = Provider.of<RestaurantProvider>(context);
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
      stream: FirebaseFirestore.instance.collection('restaurant/'+user.user.uid+'/results').orderBy('date').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Sales> sales = snapshot.data.docs.map((e) => Sales.fromMap(e.data())).toList();
          print("=======================");
          return _buildChart(context, sales);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<Sales> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Prepare food : '+mydata.last.food_prepared+' kgs today', style: kTitleStyle.copyWith(color: primaryColor)),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height *0.6 ,
                child: Expanded(
                  child: _seriesBarData.isEmpty? Text("data"): charts.BarChart(_seriesBarData,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}