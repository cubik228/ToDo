import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return  MaterialApp(
      debugShowCheckedModeBanner: false,//!убирает надпись debug
      title: "ToDo(app)",
      home: Home(),
    );
  }
}
