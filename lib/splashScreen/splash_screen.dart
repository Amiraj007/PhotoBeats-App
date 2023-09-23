import 'dart:async';
import 'package:flutter/material.dart';
import 'package:photobeats/pages/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });

    animationController = AnimationController(vsync: this,duration: Duration(seconds: 3));
    animation = Tween(begin: 0.0,end: 80.0).animate(animationController);

    animationController.addListener(() {
      setState(() {
      });
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome',
                style: TextStyle(fontSize: animation.value,
                    color: Colors.black87, decoration: TextDecoration.none,fontFamily: 'Regular')),
            const SizedBox(width: 250,
                child: LinearProgressIndicator(backgroundColor: Colors.white,color: Colors.black54,))
          ],
        ),
      ),
    );
  }
}
