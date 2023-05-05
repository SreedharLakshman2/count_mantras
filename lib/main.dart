import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './counter_view.dart';

void main() {
  // we are only allowing portrait mode
  WidgetsFlutterBinding.ensureInitialized();
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
  int count = 0;

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        //scaffoldBackgroundColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: Color.fromARGB(255, 166, 23, 174),
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
        scaffoldBackgroundColor: Color.fromARGB(255, 166, 23, 174),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Count Mantras',
                style: const TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.bold)),
          ),
          actions: [],
        ),
        body: const CounterViewWithTap(),
      ),
    );
  }
}
