import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/home/model/weather_model.dart';
import 'package:weather_app/home/service/weather_service.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  WeatherModel? weatherList;
  Future<void> getWeatherData() async {
    isLoading = true;
    notifyListeners();
    await WeatherService().getWeatherData().then(
      (value) {
        if (value != null) {
          weatherList = value;
          log(weatherList.toString());
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }
}
