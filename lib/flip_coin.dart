import 'package:flutter/material.dart';
import "dart:math";

class FlipCoin extends StatefulWidget {
  const FlipCoin({super.key});

  @override
  State<FlipCoin> createState() => FlipCoinState();
}

class FlipCoinState extends State<FlipCoin> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  final choiceArray = ["heads", "tails", "heads", "tails", "tails", "heads"];
  bool showAnimate = false;
  String flipResult = 'heads';
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            showAnimate
                ? RotationTransition(
                    turns: _animation,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset('assets/head.png'),
                    ),
                  )
                : Image.asset(
                    flipResult == 'heads'
                        ? 'assets/head.png'
                        : 'assets/tail.png',
                    width: 150,
                    height: 150,
                  ),
            SizedBox(
              height: 50,
            ),
            !showAnimate
                ? ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        showAnimate = true;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
// Here you can write your code
                        setState(() {
                          final random = new Random();
                          this.flipResult =
                              choiceArray[random.nextInt(choiceArray.length)];
                          showAnimate = false;
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Color.fromARGB(255, 166, 23, 174),
                              content: Text(
                                flipResult == 'heads'
                                    ? 'It is heads'
                                    : 'It is tails',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        });
                      });
                    },
                    icon: Icon(Icons.flip), //icon data for elevated button
                    label: Text(
                      'Flip a coin',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ), //label text
                  )
                : Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
