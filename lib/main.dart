import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///Entry point of the app.
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Document-Review',
      theme: ThemeData(
        primaryColor: const Color(0xFF6F448C),
      ),
    ),
  );
}
