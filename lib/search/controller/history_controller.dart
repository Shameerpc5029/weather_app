
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/search/model/seach_model.dart';



class HistoryService extends ChangeNotifier {
  static List<HistoryModel> historyList = [];
  Future<void> addHistory(HistoryModel value) async {
    final historyDb = await Hive.openBox<HistoryModel>('History_db');
    await historyDb.put(value.id, value);

    historyList.add(value);
    getAllStudents();
    log(historyList[0].toString());
    notifyListeners();
  }

  static Future<List<HistoryModel>> getAllStudents() async {
    final studnetDb = await Hive.openBox<HistoryModel>('History_db');
    historyList.clear();
    historyList.addAll(studnetDb.values);
    return historyList;
  }
}
