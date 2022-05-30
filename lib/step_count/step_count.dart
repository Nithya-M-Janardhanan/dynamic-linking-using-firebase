import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pedometer/pedometer.dart';

class StepCountSample extends StatefulWidget {
  const StepCountSample({Key? key}) : super(key: key);

  @override
  State<StepCountSample> createState() => _StepCountSampleState();
}

class _StepCountSampleState extends State<StepCountSample> {
  Stream<StepCount>? stepCountStream;
  Stream<PedestrianStatus>? pedestrianStatusStream;
  String? status;
  String? steps;
  String? currentCount;
  int? stepsTaken = 0;
  bool flag = false;
  StreamSubscription<StepCount>? subscription;
  double? distance;
  int? stepInt;

  void onStepCount(StepCount event){
    setState(() {
      if(stepsTaken != null){
        steps = (event.steps - stepsTaken!).toString();
        stepInt = event.steps - stepsTaken!;
        distance = (stepInt! * 0.762);
        debugPrint('steps..........$distance');
      }
    });
    // Fluttertoast.showToast(msg: steps??'///');
  }
  void onPedestrianStatusChanged(PedestrianStatus event){
    setState(() {
      status = event.status;
    });
    // Fluttertoast.showToast(msg: status??'///');
  }
  void onPedestrianStatusError(error){
   setState(() {
     status = 'Pedestrian Status not available';
   });
  }
  void onStepCountError(error){
    setState(() {
      steps = 'Step Count not available';
    });
  }

  void initPlatformState()async{
    pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    pedestrianStatusStream?.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
    stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
    StepCount? stepCount = await stepCountStream?.first;
    stepsTaken = stepCount?.steps;
    subscription = stepCountStream?.listen(onStepCount,onError: onStepCountError);
    if(!mounted) return;

  }
  void stopListening(){
    subscription?.cancel();
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            flag == false ?
            IconButton(onPressed: (){
              setState(() {
                flag = true;
                stopListening();
                stepsTaken = 0;
                steps = 0.toString();
              });
            },
                icon:Icon(Icons.pause_circle_outline) )
            : IconButton(onPressed: ()async{
              setState(() {
                flag = false;
              });
              stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
              StepCount? stepCount = await stepCountStream?.first;
              stepsTaken = stepCount?.steps;
              subscription = stepCountStream?.listen(onStepCount,onError: onStepCountError);
            },
                icon: Icon(Icons.play_circle_fill_outlined)),
            Text('Steps taken'),
            Text(steps ?? '0'),
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text('Pedestrian Status'),
            Icon(status == 'walking' ? Icons.directions_walk : status == 'stopped' ? Icons.accessibility_new : Icons.error),
            Center(
              child: Text(status ?? ''),
            ),
            Center(child: Text('Distance'),),
            Center(
              child: Text(distance.toString()),
            )
            
          ],
        ),
      ),
    );
  }
}
