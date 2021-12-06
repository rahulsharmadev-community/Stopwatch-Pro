// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '/service/stopwatchService.dart';
import 'package:provider/provider.dart';

class BottomActionButtons extends StatelessWidget {
  const BottomActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StopwatchService stopwatchService = Provider.of<StopwatchService>(context);
    return SizedBox.fromSize(
      size: const Size.fromHeight(70),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 26.0, left: 16.0, right: 16.0),
        child: stopwatchService.isReset
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  height: double.maxFinite,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    stopwatchService.lapCls();
                    stopwatchService.resume();
                  },
                  child: Text(
                    'Start',
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                ),
              )
            : Row(
                children: [
                  Expanded(
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          height: double.maxFinite,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          onPressed: () {
                            !stopwatchService.isRunning
                                ? stopwatchService.reset()
                                : stopwatchService.lap();
                          },
                          child: Text(
                            !stopwatchService.isRunning ? 'Reset' : 'Lap',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ))),
                  SizedBox.fromSize(size: const Size.fromWidth(12)),
                  Expanded(
                      child: FlatButton(
                          height: double.maxFinite,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            !stopwatchService.isRunning
                                ? stopwatchService.resume()
                                : stopwatchService.pause();
                          },
                          child: Text(
                            !stopwatchService.isRunning ? 'Resume' : 'Pause',
                            style: const TextStyle(color: Colors.white),
                          )))
                ],
              ),
      ),
    );
  }
}
