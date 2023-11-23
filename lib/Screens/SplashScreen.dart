import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_gi/Screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Get.to(HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: double.infinity,
          ),
          Image.asset('assets/icon.png',height: Get.width * .7,),
          Text(
            'BREAKING NEWS',
            style: GoogleFonts.titanOne(fontSize: 30, color: Colors.red),
          ),
          Text(
            '     From All Over The World',
            textAlign: TextAlign.left,
            style: GoogleFonts.playfair(
              fontSize: 20,
            ),
          ),
          height(),
          height(),
          height(),
          SpinKitThreeBounce(
            color: Colors.red,
            size: 30,
          ),
        ],
      ),
    );
  }
}

height() {
  return SizedBox(
    height: Get.height * .05,
    width: Get.width,
  );
}
