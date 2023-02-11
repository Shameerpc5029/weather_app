import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/home/model/current_location_model.dart';

class GetLocationService {
  Future<CurrentLocationModel?> getLoaction() async {
    Dio dio = Dio();
    try {
      final Response response =
          await dio.get("https://ipinfo.io/182.79.17.238/geo");
      if (response.statusCode == 200) {
        if (response.data == null) {
          return null;
        } else {
          final model = CurrentLocationModel.fromJson(response.data);
          return model;
        }
      }
    } catch (e) {
      log('getLocation');
      log(e.toString());
    }
    return null;
  }
}
