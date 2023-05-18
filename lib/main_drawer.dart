import 'package:count_mantras/flip_coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key, required this.backgroundColor});
  final Color backgroundColor;

  void _launchURL() async {
    const url =
        'https://www.termsfeed.com/live/51a70332-b050-4b9f-8c55-08346b1c1c7f';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor.withOpacity(0.95),
      child: Column(
        children: [
          DrawerHeader(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  backgroundColor,
                  backgroundColor.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Row(
                children: [
                  Image.asset(
                    'assets/tallyCounter.png',
                    width: 35,
                    height: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Count Mantras',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )),

          //Coin Flip Action
          ListTile(
            leading: Image.asset(
              'assets/coin.png',
              width: 35,
              height: 35,
            ),
            iconColor: Colors.white,
            title: const Text(
              'Flip a coin',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => FlipCoin(),
                ),
              );
            },
          ),

          //Privacy policy
          ListTile(
            leading: Icon(Icons.privacy_tip),
            iconColor: Colors.white,
            title: const Text(
              'Privacy policy',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onTap: _launchURL,
          ),

          //Rate us action
          ListTile(
            leading: Icon(Icons.rate_review),
            iconColor: Colors.white,
            title: const Text(
              'Rate us!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            subtitle: Text(
              'Tell us your experience',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7)),
            ),
            onTap: () {
              StoreRedirect.redirect(
                  androidAppId: 'com.sreedhar.count_mantras',
                  iOSAppId: 'com.sreedhar.countMantras');
            },
          ),
        ],
      ),
    );
  }
}
