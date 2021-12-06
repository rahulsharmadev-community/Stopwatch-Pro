// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:stopwatchpro/widgets/animatedClock.dart';
import 'package:stopwatchpro/widgets/bottomActionButtons.dart';
import '/service/stopwatchService.dart';
import 'package:provider/provider.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    StopwatchService stopwatchService = Provider.of<StopwatchService>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: -30,
              child: SizedBox(
                height: 400,
                width: 400,
                child: AnimatedClock(
                  child: stopwatchService.text(
                    100,
                    Theme.of(context)
                        .primaryTextTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w100),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox.fromSize(
                size: Size.fromHeight(MediaQuery.of(context).size.height - 456),
                child: ListView.builder(
                    itemCount: stopwatchService.lapList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (itemBuilder, index) => ListTile(
                          dense: true,
                          leading: Text(
                              '${stopwatchService.lapList.length - (index)}',
                              style:
                                  Theme.of(context).primaryTextTheme.bodyText1),
                          title: Text(
                            StopwatchService.toStringFormat(stopwatchService
                                    .lapList[
                                stopwatchService.lapList.length - (index + 1)]),
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        )),
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomActionButtons());
  }
}
