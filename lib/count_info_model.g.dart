// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounterInfoAdapter extends TypeAdapter<CounterInfo> {
  @override
  final int typeId = 0;

  @override
  CounterInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounterInfo()
      ..title = fields[0] as String
      ..createdDate = fields[1] as DateTime
      ..count = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, CounterInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
