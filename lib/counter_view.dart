import 'package:count_mantras/count_info_model.dart';
import 'package:count_mantras/history_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vibration/vibration.dart';
import "package:flutter/services.dart";
import './ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

import 'boxes.dart';

class CounterViewWithTap extends StatefulWidget {
  const CounterViewWithTap({super.key});

  @override
  State<CounterViewWithTap> createState() => CounterViewWithTapState();
}

class CounterViewWithTapState extends State<CounterViewWithTap> {
  int count = 0;
  int targetCount = 0;
  late TextEditingController controler;
  late TextEditingController saveCountInfoTitlecontroler;

  // TODO: Add _bannerAd
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    controler = TextEditingController();
    saveCountInfoTitlecontroler = TextEditingController();

// TODO: Load a banner ad
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    controler.dispose();
    saveCountInfoTitlecontroler.dispose();
    _bannerAd?.dispose();
    Hive.box('CounterInfo').close();

    super.dispose();
  }

//Show reset alert dialogue
  void showResetAlert() {
    if (count > 0 || targetCount > 0) {
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: const Text('Reset Alert',
              style: TextStyle(
                  color: Color.fromARGB(255, 251, 51, 51),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Color.fromARGB(255, 240, 125, 233),
          content: const Text('Are you sure you want to reset the counter?',
              style: TextStyle(
                  color: Color.fromARGB(255, 254, 254, 254),
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(cxt);
                },
                child: const Text('Go Back',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
            TextButton(
                onPressed: () {
                  setState(() {
                    count = 0;
                    targetCount = 0;
                    Navigator.pop(cxt);
                  });
                },
                child: const Text('Reset',
                    style: TextStyle(
                        color: Color.fromARGB(255, 251, 51, 51),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)))
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Before reset,Tap counter button to add some count.'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

//openDialogForSetTarget
  Future<String?> openDialogForSetTarget() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 240, 125, 233),
          title: const Text(
            'Set Target',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          content: TextField(
            decoration: const InputDecoration(
                hintText: "Enter target counts",
                icon: Icon(Icons.format_list_numbered)),
            controller: controler,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  controler.clear();
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
            TextButton(
                onPressed: () {
                  if (controler.text.isNotEmpty) {
                    setTargetSubmit();
                  }
                },
                child: const Text('Set Target',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)))
          ],
        ),
      );

  void setTargetSubmit() {
    //While setting target we have to reset count
    count = 0;
    Navigator.of(context).pop(controler.text);
    controler.clear();
  }

  void setTargetReached() {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: const Text(
          'Target reached alert',
          style: TextStyle(
            color: Color.fromARGB(255, 251, 250, 250),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 23, 143, 37),
        content: const Text('You have reached count target.',
            style: TextStyle(
                color: Color.fromARGB(255, 251, 250, 250),
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  count = 0;
                  targetCount = 0;
                  Vibration.cancel();
                  Navigator.pop(cxt);
                });
              },
              child: const Text('Reset & Go Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))),
          TextButton(
              onPressed: () async {
                Navigator.pop(cxt);
                if (count != 0) {
                  openDialogToSaveCounterInfo();
                }
              },
              child: const Text('Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))),
        ],
      ),
    );
  }

  //Save Counter info
  void saveCounterInfoWithTitle() {
    setState(() {
      print('Save begin');
      final counterInfo = CounterInfo()
        ..title = saveCountInfoTitlecontroler.text
        ..createdDate = DateTime.now()
        ..count = count;

      final box = Boxes.getCounterInfo();
      box.add(counterInfo);
      saveCountInfoTitlecontroler.clear();
      // clearing count, target and textfield data
      count = 0;
      targetCount = 0;
      Navigator.pop(context);
    });
  }

  //openDialog to Save counter info
  Future openDialogToSaveCounterInfo() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 240, 125, 233),
          title: Text(
            count == 0 ? 'Save event' : 'Save count event',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          content: TextField(
            decoration: const InputDecoration(
                hintText: "Enter event title",
                icon: Icon(Icons.text_fields_rounded)),
            controller: saveCountInfoTitlecontroler,
            keyboardType: TextInputType.text,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  saveCountInfoTitlecontroler.clear();
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
            TextButton(
                onPressed: () {
                  if (saveCountInfoTitlecontroler.text.isNotEmpty) {
                    saveCounterInfoWithTitle();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Add event title before save it.'),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    ));
                  }
                },
                child: const Text('Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Clear button and Settarget Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: showResetAlert,
                  icon: Icon(Icons.clear), //icon data for elevated button
                  label: Text("Reset"), //label text
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    //if (count != 0) {
                    openDialogToSaveCounterInfo();
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: const Text('Add some count before save it.'),
                    //     duration: const Duration(seconds: 3),
                    //     action: SnackBarAction(
                    //       label: '',
                    //       onPressed: () {},
                    //     ),
                    //   ));
                    // }
                  },
                  icon:
                      Icon(Icons.save_as_sharp), //icon data for elevated button
                  label: Text(
                      count > 0 ? 'Save Count' : 'Save Event'), //label text
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => History(
                          countInfoList: [],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.history), //icon data for elevated button
                  label: Text("View History"), //label text
                ),
              ],
            ),
            // TODO: Display a banner when ready
            if (_bannerAd != null)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
            const Spacer(),
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
                      if (targetCount != 0 && targetCount == count) {
                        Vibration.vibrate(duration: 3000);
                        setTargetReached();
                      }
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
              height: 5,
            ),
            const Text(
              'Tap above to count',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final count = await openDialogForSetTarget();
                if (count == null || count.isEmpty) return;
                setState(() {
                  targetCount = int.parse(count);
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(10)),
              child: Text(
                targetCount == 0
                    ? 'Set count target'
                    : 'Count target is $targetCount',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
