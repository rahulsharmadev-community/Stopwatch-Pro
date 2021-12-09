// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../service/stopwatchService.dart';

class StopwatchListViewWidget extends StatelessWidget {
  final List<Duration> laps;
  const StopwatchListViewWidget({Key? key, required this.laps})
      : super(key: key);

  Duration lapsDiff(int index) {
    return laps[index] - (index != 0 ? laps[index - 1] : Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: laps.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (itemBuilder, index) {
          var bottomIndex = (laps.length - 1) - index;
          return LimitedBox(
            maxHeight: 40,
            child: ListTile(
              dense: true,
              leading: Text('$bottomIndex',
                  style: Theme.of(context).primaryTextTheme.bodyText1),
              trailing: Text(
                  '+' +
                      (StopwatchService.toStringFormat(lapsDiff(bottomIndex))
                          .replaceAll('-', '')),
                  style: Theme.of(context).primaryTextTheme.caption),
              title: Text(
                StopwatchService.toStringFormat(laps[bottomIndex]),
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
          );
        });
  }
}
