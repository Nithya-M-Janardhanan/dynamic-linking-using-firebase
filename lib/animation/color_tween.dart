import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorTweenEx extends StatefulWidget {
  const ColorTweenEx({Key? key}) : super(key: key);

  @override
  State<ColorTweenEx> createState() => _ColorTweenExState();
}

class _ColorTweenExState extends State<ColorTweenEx>with TickerProviderStateMixin {
  late Animation<Color?> colorAnimation;
  late AnimationController controller;
  late Animation<BorderRadius?> borderRadiusAnimation;
  late Animation<Size?> sizeAnimation;
  late Animation<TextStyle?> textStyleAnimation;
  late Animation<Border?> borderAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    colorAnimation = ColorTween(begin: Colors.blue,end: Colors.red).animate(CurvedAnimation(parent: controller, curve: Curves.easeInCirc))..addListener(()
    {
      /*setState(() {

    });*/
    })..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();

      }else if(status == AnimationStatus.dismissed){
        controller.forward();
        print(status);
      }
    });
    borderRadiusAnimation = BorderRadiusTween(begin: BorderRadius.circular(30.0),end:BorderRadius.circular(1.0)).animate(controller)..addListener(() { })..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();

      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });

    sizeAnimation = SizeTween(begin: Size(100,200),end: Size(200,300)).animate(controller)..addListener(() { })..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();

      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    textStyleAnimation = TextStyleTween(begin: TextStyle(fontSize: 10,fontWeight: FontWeight.w100,fontStyle: FontStyle.normal),
        end: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)).animate(controller)..addListener(() { })..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();

      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
     controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return
              Stack(
                children: [
                  Center(
                    child: ClipRRect(
                    borderRadius: borderRadiusAnimation.value,
                    child: Container(
                    height: sizeAnimation.value?.height,
                    width: sizeAnimation.value?.width,
                      decoration: BoxDecoration(
                          color: colorAnimation.value,
                      ),
          ),),
                  ),
                  Center(child: Text('Tween Animation',style: textStyleAnimation.value))
                ],
              );

            },
        ),
      ),
    );
  }
}
