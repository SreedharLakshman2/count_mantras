import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class CounterViewWithTap extends StatefulWidget {
  const CounterViewWithTap({super.key});

  @override
  State<CounterViewWithTap> createState() => CounterViewWithTapState();
}

class CounterViewWithTapState extends State<CounterViewWithTap> {
  int count = 0;
  String targetCount = '';
  late TextEditingController controler;

  @override
  void initState() {
    super.initState();
    controler = TextEditingController();
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }

  void setTargetSubmit() {
    Navigator.of(context).pop(controler.text);
    controler.clear();
  }

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
              child: const Text('Go Back')),
          TextButton(
              onPressed: () {
                setState(() {
                  count = 0;
                  Navigator.pop(cxt);
                });
              },
              child: const Text('Reset'))
        ],
      ),
    );
  }

  Future<String?> openDialogForSetTarget() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Set counter target'),
          content: TextField(
            decoration: const InputDecoration(
                hintText: "Enter how many count you want to achieve"),
            controller: controler,
            keyboardType: const TextInputType.numberWithOptions(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  setTargetSubmit();
                },
                child: const Text('Set Target'))
          ],
        ),
      );

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
                      if (await Vibration.hasVibrator() == true) {
                        Vibration.vibrate(duration: 150);
                      }
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
                    onPressed: () async {
                      final count = await openDialogForSetTarget();
                      //if (count == null || count.isEmpty) return;
                      setState(() {
                        targetCount = count!;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(10)),
                    child: Text(
                      targetCount == ''
                          ? 'Set Target'
                          : 'Target is $targetCount counts',
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
