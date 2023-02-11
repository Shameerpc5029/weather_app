import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/home/model/ip_model.dart';

class IpService {
  Future<IpModel?> getIp() async {
    Dio dio = Dio();

    try {
      final Response response = await dio.get(
        'https://api.ipify.org/',
        queryParameters: {"format": "json"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data == null) {
          return null;
        } else {
          final model = IpModel.fromJson(response.data);
          return model;
        }
      }
    } catch (e) {
      log('ipserv');

      log(e.toString());
    }
    return null;
  }
}
