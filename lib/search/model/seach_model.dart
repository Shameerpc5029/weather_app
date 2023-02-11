import 'package:hive_flutter/hive_flutter.dart';
part 'seach_model.g.dart';

@HiveType(typeId: 1)
class HistoryModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final dynamic windspeed;

  @HiveField(2)
  final String humidity;

  @HiveField(3)
  final String pressure;

  @HiveField(4)
  final String temperature;

  @HiveField(5)
  final String city;

  HistoryModel({
    required this.windspeed,
    required this.humidity,
    required this.pressure,
    required this.temperature,
    required this.city,
    this.id,
  });
}
