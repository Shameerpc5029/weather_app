import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/search/model/seach_model.dart';

class HistoryService extends ChangeNotifier {
  static List<HistoryModel> historyList = [];
  static  List<HistoryModel> history = List.from(Set.of(historyList));


  Future<void> addHistory(HistoryModel value) async {
    final historyDb = await Hive.openBox<HistoryModel>('History_db');
    await historyDb.put(value.id, value);

    history.add(value);
    getAllStudents();
    log(history[0].toString());
    notifyListeners();
  }

  static Future<List<HistoryModel>> getAllStudents() async {
    final studnetDb = await Hive.openBox<HistoryModel>('History_db');
    history.clear();
    history.addAll(studnetDb.values);
    return history;
  }
}
