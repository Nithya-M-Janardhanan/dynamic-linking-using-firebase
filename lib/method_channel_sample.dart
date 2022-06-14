import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelSample extends StatefulWidget {
  const MethodChannelSample({Key? key}) : super(key: key);

  @override
  State<MethodChannelSample> createState() => _MethodChannelSampleState();
}

class _MethodChannelSampleState extends State<MethodChannelSample> {
  static const platform = MethodChannel('flutter.native/helper');
  String responseFromNativeCode = 'Waiting for response...';

  Future<void> responseFromNativecode()async{
    String response = '';
    try{
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
    }on PlatformException catch(e){
      response = 'failed to invoke ${e.message}';
    }
    responseFromNativeCode = response;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              responseFromNativecode();
            },
                child: Text('Call native method')),
            Text(responseFromNativeCode)
          ],
        ),
      ),
    );
  }
}




