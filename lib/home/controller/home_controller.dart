import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/home/model/current_location_model.dart';
import 'package:weather_app/home/model/ip_model.dart';
import 'package:weather_app/home/model/weather_model.dart';
import 'package:weather_app/home/service/get_location_service.dart';
import 'package:weather_app/home/service/ip_service.dart';
import 'package:weather_app/home/service/weather_service.dart';

class HomeController extends ChangeNotifier {
  bool isLoading = false;
  bool isLoading2 = false;
  WeatherModel? weatherList;
  IpModel? ipModel;
  CurrentLocationModel? locationModel;

  Future<void> getWeatherData() async {
    isLoading2 = true;
    notifyListeners();
    await WeatherService().getWeatherData(locationModel!.city).then(
      (value) {
        if (value != null) {
          weatherList = value;
          log(weatherList.toString());
          notifyListeners();
          isLoading2 = false;
          notifyListeners();
        } else {
          isLoading2 = false;
          notifyListeners();
        }
      },
    );
  }

  Future<void> getIp() async {
    isLoading = true;
    notifyListeners();
    await IpService().getIp().then(
      (value) {
        if (value != null) {
          ipModel = value;
          log(ipModel.toString());
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }

  Future<void> getCurrentLocation() async {
    isLoading = true;
    notifyListeners();
    await GetLocationService().getLoaction().then(
      (value) {
        if (value != null) {
          locationModel = value;
          notifyListeners();
          log(locationModel.toString());
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
