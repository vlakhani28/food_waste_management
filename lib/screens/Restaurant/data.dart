import 'package:cloud_firestore/cloud_firestore.dart';

class Sales {
  final Timestamp date;
  final String food_prepared;
  final String id;
  Sales(this.date,this.food_prepared,this.id);

  Sales.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['food_prepared'] != null),
        assert(map['id'] != null),
        date = map['date'],
        food_prepared = map['food_prepared'],
        id=map['id'];

  @override
  String toString() => "Record<$date:$food_prepared:$id>";
}