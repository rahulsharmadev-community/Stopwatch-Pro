// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../service/stopwatchService.dart';

class StopwatchListViewWidget extends StatelessWidget {
  final List<Duration> laps;
  const StopwatchListViewWidget({Key? key, required this.laps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: laps.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (itemBuilder, index) => LimitedBox(
              maxHeight: 40,
              child: ListTile(
                dense: true,
                leading: Text('${laps.length - (index)}',
                    style: Theme.of(context).primaryTextTheme.bodyText1),
                title: Text(
                  StopwatchService.toStringFormat(
                      laps[laps.length - (index + 1)]),
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
            ));
  }
}
