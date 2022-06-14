import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_model/gallery_screen.dart';
import 'package:firebase_model/homeScreen.dart';
import 'package:firebase_model/product_provider.dart';
import 'package:firebase_model/sample_form page_keyboard_appear_issue.dart';
import 'package:firebase_model/sliver_appbar.dart';
import 'package:firebase_model/step_count/step_count.dart';
import 'package:firebase_model/test_screen.dart';
import 'package:firebase_model/timer.dart';
import 'package:firebase_model/ui_sample.dart';
import 'package:firebase_model/video.dart';
import 'package:firebase_model/video_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'animation/color_tween.dart';
import 'animation/tween_animation.dart';
import 'cart_provider.dart';
import 'fav_provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'limo_ui.dart';

// import 'package:hive/hive.dart';
List<CameraDescription>? _cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  _cameras = await availableCameras();
  // Hive.init(directory.path);
  // Hive.registerAdapter(EmployeeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavouritesProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: CameraScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*class CameraApp extends StatefulWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
   CameraController? controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras![0], ResolutionPreset.max);
    controller?.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {

      });
    }).catchError((Object e){
      if(e is CameraException){
        switch(e.code){
          case 'CameraAccessDenied' :
            print('User denied camera access.');
            break;
          default :
            print('Handle other errors.');
            break;
        }
      }
    });
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(!controller!.value.isInitialized){
      return Container();
    }
    return CameraPreview(controller!);
  }
}*/
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  bool isCameraInitialized = false;
  List<File> capturedImages = [];
  File? imageFile;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final CameraController cameraController = CameraController(
        cameraDescription, ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg);
    await previousCameraController?.dispose();
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }
    if (mounted) {
      setState(() {
        isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(_cameras![0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    if (cameraController == null && !cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }
  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isCameraInitialized
            ?
        // Row(
        //       children: [
                Stack(
                  children: [
                    controller!.buildPreview(),
                    Center(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: ()async{
                            XFile? rawImage = await takePicture();
                            setState(() {
                              capturedImages.add(File(rawImage!.path));
                            });
                            imageFile = File(rawImage!.path);

                            int currentUnix = DateTime.now().millisecondsSinceEpoch;
                            final directory = await getApplicationDocumentsDirectory();
                            String fileFormat = imageFile!.path.split('.').last;

                            await imageFile!.copy(
                              '${directory.path}/$currentUnix.$fileFormat',
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: const [
                              Icon(Icons.circle,color: Colors.white38,size: 80,),
                              Icon(Icons.circle,color: Colors.white,size: 65,),
                            ],
                          ),
                        ),
                      ),
                    ),
        Center(
          child: GestureDetector(
            onTap: (){
              if(capturedImages.isEmpty){
                return;
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryScreen(images: capturedImages.reversed.toList())));
              }
            },
            child: Container(
              alignment: Alignment.bottomCenter,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.white,width: 2),
                        image: imageFile != null ? DecorationImage(image: FileImage(imageFile!),fit: BoxFit.cover) : null,
                    ),
                    child: Container(),
                  ),
          ),
        )
                  ],
                )
            //     Container(
            //       width: 30,
            //       decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.white,width: 2),
            //           image: imageFile != null ? DecorationImage(image: FileImage(imageFile!),fit: BoxFit.cover) : null,
            //       ),
            //       child: Container(),
            //     )
            //   ],
            // )
            : const SizedBox());
  }
}
