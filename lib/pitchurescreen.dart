import 'dart:io';

import 'package:flutter/material.dart';

class Pitchurescreen extends StatelessWidget {
  final String title;

  Pitchurescreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "PITCHURESCREEN",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: Center(
        child: Image.file(
          File(title),fit: BoxFit.fill,
        ),
      ),
    );
  }
}
