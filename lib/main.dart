import 'package:flutter/material.dart';

void main() {
  runApp(CounterView());
}

class CounterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CounterViewState();
  }
}

class CounterViewState extends State<CounterView> {
  int count = 0;
  int targetCount = 0;
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        //scaffoldBackgroundColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: Color.fromARGB(255, 166, 23, 174),
            foregroundColor: Color.fromARGB(255, 241, 240, 241)),
        cardTheme: CardTheme().copyWith(
            color: Color.fromARGB(255, 166, 23, 174),
            margin: const EdgeInsets.all(15)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 166, 23, 174),
            foregroundColor: Color.fromARGB(255, 215, 208, 215),
          ),
        ),
      ),
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: null,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            count = count + 1;
                            print("You pressed Icon Elevated Button $count");
                          });
                        },
                        child: Text(count == 0 ? 'Tap' : '$count',
                            style: const TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30),
                        ),
                      ),
                      const SizedBox(
                        width: null,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 100,
                  ),

                  //Clear button and Settarget Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            count = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Set Target',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
