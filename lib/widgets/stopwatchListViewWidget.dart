// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../service/stopwatchService.dart';

class StopwatchListViewWidget extends StatefulWidget {
  final List<Duration> laps;
  const StopwatchListViewWidget({Key? key, required this.laps})
      : super(key: key);

  @override
  State<StopwatchListViewWidget> createState() =>
      _StopwatchListViewWidgetState();
}

class _StopwatchListViewWidgetState extends State<StopwatchListViewWidget> {
  var oldValue = Duration.zero;
  Duration lapsdiff(int index) {
    var diff = widget.laps[index] - oldValue;
    oldValue = widget.laps[index];

    return diff;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.laps.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (itemBuilder, index) => LimitedBox(
              maxHeight: 40,
              child: ListTile(
                dense: true,
                leading: Text('${widget.laps.length - (index)}',
                    style: Theme.of(context).primaryTextTheme.bodyText1),
                trailing: Text(
                    StopwatchService.toStringFormat(
                        lapsdiff(widget.laps.length - (index + 1))),
                    style: Theme.of(context).primaryTextTheme.bodyText1),
                title: Text(
                  StopwatchService.toStringFormat(
                      widget.laps[widget.laps.length - (index + 1)]),
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
            ));
  }
}
