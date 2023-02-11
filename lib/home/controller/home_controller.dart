import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/home/model/current_location_model.dart';
import 'package:weather_app/home/model/ip_model.dart';
import 'package:weather_app/home/model/weather_model.dart';
import 'package:weather_app/home/service/get_location_service.dart';
import 'package:weather_app/home/service/ip_service.dart';
import 'package:weather_app/home/service/weather_service.dart';
import 'package:weather_app/search/model/seach_model.dart';
import 'package:weather_app/search/service/search_service.dart';

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
    await WeatherService().getWeatherData(locationModel!.ip).then(
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

  void history() {
    final history = HistoryModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      windspeed: weatherList?.current.windKph.toDouble() ?? '',
      humidity: weatherList?.current.humidity.toString() ?? "",
      pressure: weatherList?.current.pressureMb.toString() ?? "",
      temperature: weatherList?.current.tempC.toString() ?? '',
      city: weatherList?.location.name.toString() ?? '',
    );
    HistoryService().addHistory(history);
    notifyListeners();
  }

  List<HistoryModel> resultList = [];

  TextEditingController searchController = TextEditingController();
  void search(String keyboard) {
    List<HistoryModel> results;
    if (keyboard.isEmpty) {
      results = resultList;
      resultList.clear();
    } else {
      results = HistoryService.historyList
          .where((element) => element.city.toLowerCase().contains(
                keyboard.toLowerCase(),
              ))
          .toList();
    }

    resultList = results;
    notifyListeners();
  }
}
