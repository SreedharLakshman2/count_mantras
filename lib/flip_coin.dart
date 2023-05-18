import 'package:flutter/material.dart';

class FlipCoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 166, 23, 174),
        title: Text(
          'Flip a coin',
          style: TextStyle(
              color: Color.fromARGB(255, 112, 2, 118),
              fontSize: 20,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/tail.png'),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
