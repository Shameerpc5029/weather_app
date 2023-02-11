class CurrentLocationModel {
  CurrentLocationModel({
    required this.ip,
    required this.city,
  });

  String? ip;
  String? city;

  factory CurrentLocationModel.fromJson(Map<String, dynamic> json) =>
      CurrentLocationModel(
        ip: json["ip"],
        city: json["city"],
      );
}
