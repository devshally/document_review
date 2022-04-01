import 'package:document_review/app/models/document_model.dart';
import 'package:document_review/app/ui/add_document.dart';
import 'package:document_review/app/ui/home.dart';
import 'package:document_review/app/ui/login.dart';
import 'package:document_review/app/ui/review.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ///Go router makes use of Flutter Navigation 2.0.
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/review',
        builder: (BuildContext context, GoRouterState state) {
          final DocumentModel document = state.params as DocumentModel;
          return ReviewDocument(
            documentModel: document,
          );
        },
      ),
      GoRoute(
        path: '/addDocument',
        builder: (BuildContext context, GoRouterState state) =>
            const AddDocumentScreen(),
      ),
    ],
  );

  ///Entry point of the app.
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Document-Review',
      theme: ThemeData(
        primaryColor: const Color(0xFF6F448C),
      ),
    ),
  );
}



///Status :- uploaded, passed, ammend, default on upload is uploaded.
// enum Status {
//   uploaded,
//   passed,
//   ammend,
//   defaultOnUpload,
// }
