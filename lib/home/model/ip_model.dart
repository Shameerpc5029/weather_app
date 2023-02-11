class IpModel {
  IpModel({
    required this.ip,
  });

  String ip;

  factory IpModel.fromJson(Map<String, dynamic> json) => IpModel(
        ip: json["ip"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
      };
}
