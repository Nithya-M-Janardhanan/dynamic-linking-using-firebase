
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homeScreen.dart';
import '../test_screen.dart';
class TweenEx extends StatefulWidget {
  const TweenEx({Key? key}) : super(key: key);

  @override
  State<TweenEx> createState() => _TweenExState();
}

class _TweenExState extends State<TweenEx>with SingleTickerProviderStateMixin {
  AnimationController? controller;
  double targetValue = 60.0;
  Animation<double>? animation;
  late Animation<double> opacityAnimation;


  @override
  void initState() {
      controller = AnimationController(vsync: this,duration: const Duration(milliseconds: 800));
      animation= Tween<double>(begin: 1,end: 3).animate(controller!);
      controller?.addStatusListener((AnimationStatus status) {
        if(status == AnimationStatus.completed){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        }
      });
      opacityAnimation = Tween<double>(begin: 1,end: 0).animate(CurvedAnimation(parent: controller!, curve: Curves.easeIn));
      Future.delayed(Duration(seconds: 2),(){
        controller?.forward();
      });
    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller!,
          child: Text('Splash',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.green)),
          builder: (BuildContext context, Widget? child) {
            return
              Transform.scale(scale: animation?.value,
                child: Opacity(opacity: opacityAnimation.value,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/bg3.jpg'),fit: BoxFit.cover)),
                    child: Center(child: child))),
            );
          },
        )
        // TweenAnimationBuilder<double>(
        //     tween: Tween<double>(begin: 0,
        //         end: targetValue),
        //     duration: const Duration(seconds: 1),
        //     builder: (BuildContext context,double size,Widget? child){
        //       return GestureDetector(
        //         child: Text('Splash',style: TextStyle(fontSize: size,fontWeight: FontWeight.bold,)),
        //         onTap: (){
        //           setState(() {
        //               targetValue = targetValue == 60.0 ? 100.0 :60.0;
        //             });
        //         },
        //       );
        //       //   IconButton(onPressed: (){
        //       //   setState(() {
        //       //     targetValue = targetValue == 60.0 ? 100.0 :60.0;
        //       //   });
        //       // },
        //       //     icon: Text('Splash',style: TextStyle(fontSize: size,fontWeight: FontWeight.bold,)),
        //       // iconSize: size,
        //       // );
        //     },
        // ),
      ),
    );
  }
}
