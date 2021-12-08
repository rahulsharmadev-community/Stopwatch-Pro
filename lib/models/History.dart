// ignore_for_file: file_names

import 'dart:convert';

class History {
  History(
      {this.title, required this.date, required this.time, required this.laps});

  final String? title;
  final String date;
  final String time;
  final List<String> laps;

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory History.fromJson(Map<String, dynamic> json) => History(
        title: json["title"],
        date: json["date"],
        time: json["time"],
        laps: List<String>.from(json["laps"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "time": time,
        "laps": List<dynamic>.from(laps.map((x) => x)),
      };
}
