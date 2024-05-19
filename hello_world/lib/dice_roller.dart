import 'package:flutter/material.dart';
import 'dart:math'; // this is not third party package have to registered in the pubspec.yaml file

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    // TODO: implement createState
    return _DiceRollerState();
  }
}

//TODO: Golbal varibale for random object
final randomizer = Random();

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-2.png';
  var currentDiceRoll = 2;

  void rollDice() {
    setState(() {
      //activeDiceImage = 'assets/images/dice-4.png';
      currentDiceRoll = randomizer.nextInt(6) + 1; // 1~6
    });
    // provided by this state class provided by Flutter
    //tells flutter it should be re-execute the build function
  }

  @override
  Widget build(context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          //'assets/images/dice-2.png',
          //activeDiceImage,
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(height: 20),
        TextButton(
            onPressed: rollDice,
            style: TextButton.styleFrom(
              // padding: const EdgeInsets.only(top: 50),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 28),
            ),
            child: const Text('Roll Dice'))
      ],
    );
  }
}
