class CurrentLocationModel {
  CurrentLocationModel({
    required this.ip,
    required this.city,
    required this.region,
    required this.country,
    required this.loc,
    required this.org,
    required this.postal,
    required this.timezone,
    required this.readme,
  });

  String ip;
  String city;
  String region;
  String country;
  String loc;
  String org;
  String postal;
  String timezone;
  String readme;

  factory CurrentLocationModel.fromJson(Map<String, dynamic> json) =>
      CurrentLocationModel(
        ip: json["ip"],
        city: json["city"],
        region: json["region"],
        country: json["country"],
        loc: json["loc"],
        org: json["org"],
        postal: json["postal"],
        timezone: json["timezone"],
        readme: json["readme"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "city": city,
        "region": region,
        "country": country,
        "loc": loc,
        "org": org,
        "postal": postal,
        "timezone": timezone,
        "readme": readme,
      };
}
