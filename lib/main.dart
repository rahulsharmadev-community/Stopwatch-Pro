import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../service/stopwatchService.dart';
import '../service/userPreferences.dart';
import 'pages/stopwatchPage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
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
            themeMode: ThemeMode.dark,
            theme: ThemeData(
                canvasColor: const Color(0xff232323),
                primaryColor: const Color(0xffFC5B34),
                dialogTheme: const DialogTheme(
                    backgroundColor: Color(0xff232323),
                    titleTextStyle: TextStyle(
                        color: Color(0xffFC5B34),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    contentTextStyle: TextStyle(color: Colors.white)),
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                primaryTextTheme: const TextTheme(
                    bodyText1: TextStyle(fontSize: 15, letterSpacing: 0.5),
                    headline5: TextStyle(fontFamily: 'ReadexPro'))),
            home: const StopwatchPage(title: 'Stopwatch Pro'),
          );
        });
  }
}
