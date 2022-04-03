import 'package:document_review/app/features/DocumentReview/presentation/cubit/documentreview_cubit.dart';
import 'package:document_review/app/features/DocumentReview/presentation/pages/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///Entry point of the app.
  runApp(
    BlocProvider(
      create: (context) => DocumentreviewCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Document-Review',
        theme: ThemeData(
          primaryColor: const Color(0xFF6F448C),
        ),
        home: const LoginScreen(),
      ),
    ),
  );
}
