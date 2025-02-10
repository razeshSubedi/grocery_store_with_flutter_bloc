import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal ,
          appBarTheme: AppBarTheme(
        color: Colors.teal,
      )),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
