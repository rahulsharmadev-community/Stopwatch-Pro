// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StopwatchService extends ChangeNotifier {
  late Stopwatch _stopwatch;
  bool _isReset = true;
  bool _isRunning = false;
  List<Duration> _lapList = [];

  StopwatchService() {
    _stopwatch = Stopwatch();
  }

  void resume() {
    _isRunning = true;
    _isReset = false;
    _stopwatch.start();
    notifyListeners();
  }

  void pause() {
    _isRunning = false;
    _stopwatch.stop();
    notifyListeners();
  }

  void reset() {
    _isReset = true;
    _stopwatch.reset();
    _stopwatch.stop();
    notifyListeners();
  }

  void lap() {
    _lapList.add(_stopwatch.elapsed);
    notifyListeners();
  }

  void lapCls() {
    _lapList.clear();
    notifyListeners();
  }

  List<Duration> get lapList => _lapList;

  bool get isReset => _isReset;

  bool get isRunning => _isRunning;

  Stream<Duration> _timerStream(refreshTime) => Stream<Duration>.periodic(
      Duration(milliseconds: refreshTime), (value) => _stopwatch.elapsed);

  /// Widget rebuild Time in milliseconds
  StreamBuilder text<Duration>(int? refreshTime, TextStyle? style) {
    return StreamBuilder(
      stream: _timerStream(refreshTime ?? 100),
      builder: (context, snapshot) =>
          Text(toStringFormat(_stopwatch.elapsed), style: style),
    );
  }

  static Duration toDurationFormat(String string) => Duration(
      minutes: int.parse(string.split(':')[0]),
      seconds: int.parse(string.split(':')[1]),
      milliseconds: int.parse(string.split(':')[2]));

  static String toStringFormat(Duration duration) =>
      '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
      '${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}:'
      '${duration.inMilliseconds.remainder(60).toString().padLeft(2, '0')}';
}
