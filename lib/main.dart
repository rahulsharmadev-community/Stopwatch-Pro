import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatchpro/service/stopwatchService.dart';
import 'pages/stopwatchPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding.instance;
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StopwatchService>.value(
        value: StopwatchService(),
        builder: (context, child) {
          return MaterialApp(
            title: 'Stopwatch Pro',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                canvasColor: const Color(0xff232323),
                primaryColor: const Color(0xffFC5B34),
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                primaryTextTheme: const TextTheme(
                    bodyText1: TextStyle(fontSize: 15, letterSpacing: 0.5),
                    headline5: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w300,
                    ))),
            home: const StopwatchPage(title: 'Stopwatch Pro'),
          );
        });
  }
}
