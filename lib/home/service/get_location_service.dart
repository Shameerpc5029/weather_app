import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/home/model/current_location_model.dart';

class GetLocationService {
  Future<CurrentLocationModel?> getLoaction(ip) async {
    print(ip);
    Dio dio = Dio();
    try {
      final Response response = await dio.get(
        'https://ipinfo.io/$ip/geo',
      );
      if (response.statusCode == 200) {
        if (response.data == null) {
          return null;
        } else {
          final model = CurrentLocationModel.fromJson(response.data);
          return model;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
