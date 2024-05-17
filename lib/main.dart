import 'dart:async';
import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shake/shake.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        fontFamily: 'SpaceMono',
      ),
      home: const Dice(),
    );
  }
}

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DiceState();
  }
}

class _DiceState extends State<Dice> {

  late ShakeDetector shake;
  late double shakeThresholdGravity;


  @override
  void initState() {
    shake = ShakeDetector.waitForStart(onPhoneShake: () => update(), shakeThresholdGravity: shakeThresholdGravity = 1.5);
    super.initState();
    shake.startListening();
  }
  double scale = 1;
  double turns = 0;
  final List diceImage = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
  ];
  int diceno = 1;
  void update() {
    setState(() {
      scale = 0;
      turns= 10;
    });
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        scale = 1;
        turns=0;
        diceno = Random().nextInt(6) + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              // onTap: () => shake.startListening(),
              child: Column(
                children: [
                  AnimatedRotation(
                    turns: turns,
                    duration: const Duration(seconds: 1),
                    child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Image.asset('assets/images/$diceno.png')),
                  ),
                  ElevatedButton(onPressed: update, child: const Text("Click me")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
