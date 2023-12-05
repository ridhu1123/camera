// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// saveimage() async {
//   //ask permission
//   var status = await Permission.storage.status;
//   if (status.isDenied) {}
//   // You can request multiple permissions at once.
//   Map<Permission, PermissionStatus> statuses = await [
//     Permission.storage,
//     Permission.camera,
//   ].request();
//   print(
//       statuses[Permission.storage]); // it should print PermissionStatus.granted

//   //create an folder with named by ridhu

//   var status = await Permission.storage.request();
//                 if(status==PermissionStatus.granted){
//                 var read = await File(image).readAsBytes();
//                 var newfile = await File("/storage/ridhun/0/filename.png")
//                     .create(recursive: true);
//                 await newfile.writeAsBytes(read);
//                 }
//   //save the file to that folder
// }

// Future<String> getFilePath() async {
//   Directory appDocumentsDirectory =
//       await getApplicationDocumentsDirectory(); // 1
//   String appDocumentsPath = appDocumentsDirectory.path; // 2
//   String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

//   return filePath;
// }

// class gallery extends StatefulWidget {
//   const gallery({super.key});

//   @override
//   State<gallery> createState() => _galleryState();
// }

// class _galleryState extends State<gallery> {
//   String? image;

//   // void saveFile() async {
//   //   File file = File(await getFilePath()); // 1
//   //   file.writeAsString(
//   //       "This is my demo text that will be saved to : demoTextFile.txt"); // 2
//   // }

//   @override
//   Widget build(BuildContext context) {
//     print(context);
//     String image = "";
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 50,
//             width: 50,
//           ),
//           image.isEmpty ? Container() : Image.file(File(image)),
//           ElevatedButton(
//               onPressed: () async {
//                 var status = await Permission.storage.request();
//                 var image =
//                     await ImagePicker().pickImage(source: ImageSource.gallery);
//                 if (image != null) {
//                   setState(() {
//                     this.image = image.path;
//                   });
//                 }
//               },
//               child: Text("image")),
//           ElevatedButton(
//               onPressed: () async {
              
               
//               },
//               child: Text("read"))
//         ],
//       ),
//     );
//   }
// }
