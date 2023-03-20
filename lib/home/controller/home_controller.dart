import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:weather_app/home/model/weather_model.dart';

import 'package:weather_app/home/service/weather_service.dart';
import 'package:weather_app/search/controller/history_controller.dart';
import 'package:weather_app/search/model/seach_model.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    getPosition();
    history();
  }
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  WeatherModel? weatherList;
  dynamic lat;
  dynamic lon;

  Future<void> getWeatherData() async {
    isLoading3 = true;
    notifyListeners();

    await WeatherService().getWeatherData(lat, lon).then(
      (value) {
        if (value != null) {
          getPosition();
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

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    lat = position.latitude;
    lon = position.longitude;
  }

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    getLocation();

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
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
      results = HistoryService.history
          .where((element) => element.city.toLowerCase().contains(
                keyboard.toLowerCase(),
              ))
          .toList();
    }
    resultList = results;
    notifyListeners();
  }
}
