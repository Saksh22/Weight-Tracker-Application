// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weights_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightAdapter extends TypeAdapter<Weight> {
  @override
  final typeId = 0;

  @override
  Weight read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weight(
      fields[0] as String,
      fields[1] as double,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Weight obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.weight);
  }
}
