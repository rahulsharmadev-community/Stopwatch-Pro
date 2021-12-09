// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';
import '../models/History.dart';

abstract class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyHistoryList = 'HistoryList';
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> addHistory(History history) async {
    var tempList = _preferences.getStringList(_keyHistoryList) ?? [];
    tempList.insert(0, history.toRawJson());
    await _preferences.setStringList(_keyHistoryList, tempList);
  }

  static Future<void> deleteHistory(int index) async {
    var tempList = _preferences.getStringList(_keyHistoryList) ?? [];
    tempList.removeAt(index);
    await _preferences.setStringList(_keyHistoryList, tempList);
  }

  static Future<void> cleanHistory() async =>
      await _preferences.setStringList(_keyHistoryList, []);

  static Future<void> UpdateHistoryTitle(int index, String title) async {
    var tempList = _preferences.getStringList(_keyHistoryList) ?? [];
    var old = History.fromRawJson(tempList[index]);
    tempList[index] =
        History(title: title, date: old.date, time: old.time, laps: old.laps)
            .toRawJson();
    await _preferences.setStringList(_keyHistoryList, tempList);
  }

  static List<History> get getHistory {
    List<History> returnList = [];
    var tempList = _preferences.getStringList(_keyHistoryList) ?? [];
    tempList.forEach((element) {
      returnList.add(History.fromRawJson(element));
    });
    return returnList;
  }
}
