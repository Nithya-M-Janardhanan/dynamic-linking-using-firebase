import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_model/sample_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test'),),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SampleForm()));
            },
          child: null,

          ),
        ),
      ),

    );
  }
}
