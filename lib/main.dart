import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:cameraproject/pitchurescreen.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:core';

late List<CameraDescription>? cameras;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController controller;

  String imagePath = "";

  bool loading = false;
  Future<bool?> saveFile(String url, String filename) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          print(directory!.path);
        } else {
          return false;
        }
      } else {}
    } catch (err) {}

    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = true;
    });
    bool? download = await saveFile(
        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
        "image.mp3");
    if (download!) {
      print("file Downloaded");
    } else {
      print("problem downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![0], ResolutionPreset.max);
    controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case "CameraAcceddDenaied":
            print("access was denied");
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
    final screenSize = MediaQuery.of(context).size;

    // if (!controller!.value.isInitialized) {
    //   return Container();
    // }
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 30,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: CircleAvatar(
              radius: 40,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.flash_off_outlined,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Container(
          height: screenSize.height,
          width: screenSize.width,
          child: CameraPreview(
            controller,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 100,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 45, right: 45, bottom: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(width: 0.8, color: Colors.white30),
                  ),
                  height: 80,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Pitchurescreen(title: imagePath)));
                          },
                          child: CircleAvatar(
                            radius: 25,
                            // backgroundImage: FileImage(),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.35)),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.flip_camera_ios_outlined,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Positioned(
        //     bottom: 0.0,
        //     child: Container(
        //       width: MediaQuery.of(context).size.width,
        //       child: Padding(
        //           padding: const EdgeInsets.only(left: 15, bottom: 40),
        //           child: Row(
        //             children: [
        //               Expanded(
        //                 flex: 1,
        //                 child: InkWell(
        //                   radius: 20,
        //                   onTap: () {
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) =>
        //                               Pitchurescreen(title: imagePath)),
        //                     );
        //                   },
        //                   child: Image.file(File(imagePath)),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 35,
        //               ),
        //               Expanded(
        //                 flex: 2,
        //                 child: IconButton(
        //                   onPressed: () async {
        //                     saveFile(
        //                         "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
        //                         "image.mp3");
        //                     // var read =  var status = await Permission.s await File(imagePath).readAsBytes();
        //                     // var newfile =
        //                     //     await File("/storage/ridhun/filename.png")
        //                     //         .create(recursive: true);

        //                     // try {
        //                     //   final image = await controller!.takePicture();

        //                     //   setState(() async {
        //                     //     imagePath = image.path;
        //                     //     var status = await Permission.storage.request();
        //                     //     if (status == PermissionStatus.granted) {
        //                     //       var response =
        //                     //           await http.get(Uri.parse(imagePath));
        //                     //       Directory? externalStorageDirectory =
        //                     //           await getExternalStorageDirectory();
        //                     //       File file = new File(path.join(
        //                     //           externalStorageDirectory!.path,
        //                     //           path.basename(imagePath)));
        //                     //       await file.writeAsBytes(response.bodyBytes);
        //                     // showDialog(
        //                     //     context: context,
        //                     //     builder: (BuildContext context) =>
        //                     //         AlertDialog(
        //                     //           title:
        //                     //               Text("Image saved succesfully"),
        //                     //           content: Image.file(file),
        //                     //         ));
        //                   }

        //                   //   var newfile = await File(
        //                   //           '/storage/emulated/0/filename.png')
        //                   //       .create(recursive: true);
        //                   //   await newfile
        //                   //       .writeAsBytes(imagePath as List<int>);
        //                   // });
        //                   // } catch (e) {
        //                   //   print(e);
        //                   // }

        //                   // Navigator.push(
        //                   //     context,
        //                   //     MaterialPageRoute(
        //                   //         builder: (context) =>
        //                   //             Pitchurescreen(title: imagePath)));
        //                   // },
        //                   ,
        //                   icon: const Icon(
        //                     Icons.radio_button_checked_sharp,
        //                     color: Colors.white,
        //                     size: 70,
        //                   ),
        //                 ),
        //               ),
        //               Expanded(
        //                 flex: 2,
        //                 child: IconButton(
        //                     onPressed: () {},
        //                     // Navigator.push(
        //                     //     context,
        //                     //     MaterialPageRoute(
        //                     //         builder: (context) => gallery()));

        //                     icon: Icon(
        //                       Icons.flip_camera_ios_rounded,
        //                       size: 50,
        //                     )),
        //               )
        //             ],
        //           ),
        //           ),
        //     ),
        //     )
      ]),
    );
  }
}
