import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Data {
  final String date;
  final String index;
  final String food_prepared;
  charts.Color barColor;

  Data({
    @required this.date,
    @required this.index,
    @required this.food_prepared,
    this.barColor
  }) {
    barColor = charts.ColorUtil.fromDartColor(Colors.black);
  }

  factory Data.fromSnapshot(DocumentSnapshot snap, String index)
  {
    return Data(
      date: snap["date"],
      index: index,
      food_prepared: snap["food_prepared"],
    );
  }
  static final List<Data> data = [
    Data(date: "24 Apr 22", index: "6q95f008B7HYlMiJEd2n", food_prepared: "63.5"),
    Data(date: "25 Apr 22", index: "Io2U1NjHiGT9fv7Yu8CF", food_prepared: "45.5"),
    Data(date: "26 Apr 22", index: "d4aM61upTfUwO7X0RTBA", food_prepared: "47.5"),
    Data(date: "27 Apr 22", index: "FX4ufX0HL3D95osirAV7", food_prepared: "45.6"),
    Data(date: "28 Apr 22", index: "YjwriOJ0d546lCQsuiGY", food_prepared: "49.75"),
    Data(date: "29 Apr 22", index: "40jZg8aTkjz9CuFiTll4", food_prepared: "63.75"),
    Data(date: "30 Apr 22", index: "K3jXLOzKDo7r3ysjXPiY", food_prepared: "58.25"),
    Data(date: "01 May 22", index: "0s2nM0qdM9O8mz4d3CYl", food_prepared: "59.00"),
    Data(date: "02 May 22", index: "0jfLFgPBgxDgmbXbWg8T", food_prepared: "46.75"),
    Data(date: "03 May 22", index: "jF4aswYBoAmLhoFzBATo", food_prepared: "48.96"),
    Data(date: "04 May 22", index: "OiQExi85ov0T6nq8HDJU", food_prepared: "52.43"),
  ];
}
