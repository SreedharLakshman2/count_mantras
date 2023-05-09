import 'package:count_mantras/boxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './counter_view.dart';
// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'count_info_model.dart';
import './count_info_model.dart';
import "dart:math";

Future main() async {
  // we are only allowing portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //Registering Hive
  Hive.registerAdapter(CounterInfoAdapter());
  //Opening hive
  await Hive.openBox<CounterInfo>('CounterInfo');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(CounterView());
  });
}

class CounterView extends StatefulWidget {
  CounterView({super.key});
  @override
  State<CounterView> createState() {
    return CounterViewState();
  }
}

class CounterViewState extends State<CounterView> {
  var backgroundColor = Color.fromARGB(255, 166, 23, 174);
  List<Color> backgroundColorColorList = [
    Color.fromARGB(255, 166, 23, 174),
    Color.fromARGB(255, 174, 58, 23),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 79, 66, 195),
    Color.fromARGB(255, 7, 6, 6)
  ];

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        //scaffoldBackgroundColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: backgroundColor,
            foregroundColor: Color.fromARGB(255, 255, 255, 255)),
        cardTheme: CardTheme().copyWith(
            color: Color.fromARGB(255, 166, 23, 174),
            margin: const EdgeInsets.all(15)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 112, 2, 118),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Count Mantras',
                style: TextStyle(
                    color: Color.fromARGB(255, 250, 224, 249),
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
          ),
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: Color.fromARGB(255, 101, 33, 104),
              ),
              onPressed: () {
                setState(() {
                  final random = new Random();
                  this.backgroundColor = backgroundColorColorList[
                      random.nextInt(backgroundColorColorList.length)];
                });
              },
              child: Row(children: [
                Text(
                  'Change Color',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Icon(
                  Icons.color_lens,
                  color: Color.fromARGB(255, 255, 255, 255),
                )
              ]),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: const CounterViewWithTap(),
      ),
    );
  }
}
