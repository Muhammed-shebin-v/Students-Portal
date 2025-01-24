import 'dart:async';
import 'package:database/db/database/function.dart';
import 'package:database/Screens/screenbottom.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
  runApp(const NewApp());
}

class NewApp extends StatelessWidget {
  const NewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Portal',
      theme: ThemeData(primaryColor: Colors.black),
      home: const Bottom(),
    );
  }
}
