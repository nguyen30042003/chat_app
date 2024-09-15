import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../configuation/app_vectors_and_images.dart';
import 'get_started.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    redirect();
  }
  Future<void> redirect() async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GetStarted()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppVectorsAndImages.getLinkImage('icon_app'), // Runtime method invocation
        ),
      ),
    );
  }

}
