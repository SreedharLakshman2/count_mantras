import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import "package:flutter/services.dart";
// TODO: Import ad_helper.dart
import './ad_helper.dart';
// TODO: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CounterViewWithTap extends StatefulWidget {
  const CounterViewWithTap({super.key});

  @override
  State<CounterViewWithTap> createState() => CounterViewWithTapState();
}

class CounterViewWithTapState extends State<CounterViewWithTap> {
  int count = 0;
  int targetCount = 0;
  late TextEditingController controler;
  // TODO: Add _bannerAd
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    controler = TextEditingController();

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
    _bannerAd?.dispose();

    super.dispose();
  }

//Show reset alert dialogue
  void showResetAlert() {
    if (count > 0 || targetCount > 0) {
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
                    targetCount = 0;
                    Navigator.pop(cxt);
                  });
                },
                child: const Text('Reset'))
          ],
        ),
      );
    }
  }

//openDialogForSetTarget
  Future<String?> openDialogForSetTarget() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Set counter target'),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter counts"),
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
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (controler.text.isNotEmpty) {
                    setTargetSubmit();
                  }
                },
                child: const Text('Set Target'))
          ],
        ),
      );

  void setTargetSubmit() {
    Navigator.of(context).pop(controler.text);
    controler.clear();
  }

  void setTargetReached() {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: const Text('Target reached alert'),
        content: const Text('You have reached count target.'),
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
              child: const Text('Reset & Go Back')),
          TextButton(
              onPressed: () {
                setState(() {
                  targetCount = 0;
                  Vibration.cancel();
                  Navigator.pop(cxt);
                });
              },
              child: const Text('Go Back & Continue')),
        ],
      ),
    );
  }

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
                ElevatedButton(
                  onPressed: showResetAlert,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10)),
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
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
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
