import 'dart:async';

import 'package:api_check/Home_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this
  )..repeat();
 
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
    ()=>Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage())))
  );
  }

  Widget build(BuildContext context) {
    return SafeArea
    (
      child: Scaffold(backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: controller,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.50,
                  width: MediaQuery.of(context).size.width*0.50,
                  child:const Image(image: AssetImage("assests/images/virus.png")), // Correct the asset path
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
              Text("COVID_19 Tracking",style: TextStyle(color: Colors.black,fontSize: 25),)
            ],
          ),
        ),
      ),
    );
  }
}