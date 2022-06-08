import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SampleForm extends StatefulWidget {
  const SampleForm({Key? key}) : super(key: key);

  @override
  State<SampleForm> createState() => _SampleFormState();
}

class _SampleFormState extends State<SampleForm> {
  bool keyBoardVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    keyBoardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(title: Text('Sample Form'),),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 12.0),
                child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter Designation',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter City',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter Area',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter LandMark',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                        ),
                        const SizedBox(height: 50.0,),
                      ],
                    )
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () {
          //
          //     }, child: Text('Save'),
          //
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: keyBoardVisible ? Icon(Icons.message) : Icon(Icons.aspect_ratio),
      ),
    );
  }
}
