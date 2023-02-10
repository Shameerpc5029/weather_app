import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/home/model/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getWeatherData() async {
    Dio dio = Dio();
    try {
      final Response response = await dio.get(
        'https://api.weatherapi.com/v1/current.json',
        queryParameters: {
          "key": "c0dbb6f1794640eeabf103014222805",
          "q": "kerala",
          "aqi": "no",
        },
      );
      if (response.statusCode == 200) {
        final model = WeatherModel.fromJson(response.data);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
