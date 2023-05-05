import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CounterViewWithTap extends StatefulWidget {
  const CounterViewWithTap({super.key});

  @override
  State<CounterViewWithTap> createState() => CounterViewWithTapState();
}

class CounterViewWithTapState extends State<CounterViewWithTap> {
  int count = 0;

  void showResetAlert() {
//Show error dialogue
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: const Text('Reset Alert'),
        content: const Text('Are you sure you want to reset the counter?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(cxt);
              },
              child: Text('Go Back')),
          TextButton(
              onPressed: () {
                setState(() {
                  count = 0;
                  Navigator.pop(cxt);
                });
              },
              child: Text('Reset'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onPressed: () async {
                      Vibration.vibrate(duration: 200);
                      setState(() {
                        count = count + 1;
                        print(
                            "You pressed Icon Elevated Button $widget.count times");
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(50),
                    ),
                    child: Text(count == 0 ? 'Tap' : '$count',
                        style: const TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: showResetAlert,
                    style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(10)),
                    child: const Text(
                      'Reset',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(10)),
                    child: const Text(
                      'Set Target',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
