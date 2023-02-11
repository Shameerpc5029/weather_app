import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/home/model/current_location_model.dart';
import 'package:weather_app/home/model/ip_model.dart';
import 'package:weather_app/home/model/weather_model.dart';
import 'package:weather_app/home/service/get_location_service.dart';
import 'package:weather_app/home/service/ip_service.dart';
import 'package:weather_app/home/service/weather_service.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getIp();
  }
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  WeatherModel? weatherList;
  IpModel? ipModel;
  CurrentLocationModel? locationModel;

  Future<void> getWeatherData() async {
    isLoading3 = true;
    notifyListeners();
    await WeatherService().getWeatherData(locationModel?.city).then(
      (value) {
        if (value != null) {
          weatherList = value;
          log(weatherList.toString());
          notifyListeners();
          isLoading3 = false;
          notifyListeners();
        } else {
          isLoading3 = false;
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }

  Future<void> getIp() async {
    isLoading2 = true;
    notifyListeners();
    await IpService().getIp().then(
      (value) {
        if (value != null) {
          getCurrentLocation();
          notifyListeners();
          ipModel = value;
          log(ipModel.toString());
          isLoading2 = false;
          notifyListeners();
        } else {
          isLoading2 = false;
          notifyListeners();
        }
      },
    );
  }

  Future<void> getCurrentLocation() async {
    isLoading = true;
    notifyListeners();
    await GetLocationService().getLoaction(ipModel?.ip ?? '').then(
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
