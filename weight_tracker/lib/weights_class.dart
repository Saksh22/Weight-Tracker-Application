import 'package:hive/hive.dart';

part 'weights_class.g.dart';

@HiveType(typeId: 0)

class Weight{
  @HiveField(0)
  String date;
  @HiveField(1)
  double weight;
  @HiveField(2)
  bool submitted;

  Weight(this.date,this.weight,this.submitted);

}