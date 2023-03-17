
import 'dart:typed_data';

class DeviceModel {
  final String title;
  final Uint8List value;
  final String? name;
  final String? time;
  final String? magv;

  DeviceModel({required this.title, required this.value,this.name,this.time,this.magv});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceModel &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}