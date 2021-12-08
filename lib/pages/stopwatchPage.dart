// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../widgets/animatedClock.dart';
import '../widgets/bottomActionButtons.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/stopwatchListViewWidget.dart';
import '/service/stopwatchService.dart';
import 'package:provider/provider.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    StopwatchService stopwatchService = Provider.of<StopwatchService>(context);
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            widget.title,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            IconButton(
                color: Colors.white,
                onPressed: () => globalKey.currentState!.openEndDrawer(),
                icon: const Icon(Icons.history))
          ],
        ),
        endDrawer: const DrawerWidget(),
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
                  size:
                      Size.fromHeight(MediaQuery.of(context).size.height - 456),
                  child: StopwatchListViewWidget(
                    laps: stopwatchService.lapList,
                  )),
            )
          ],
        ),
        bottomNavigationBar: const BottomActionButtons());
  }
}
