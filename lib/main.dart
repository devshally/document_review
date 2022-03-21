import 'package:document_review/app/ui/add_document.dart';
import 'package:document_review/app/ui/home.dart';
import 'package:document_review/app/ui/login.dart';
import 'package:document_review/app/ui/review.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
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
        builder: (BuildContext context, GoRouterState state) =>
            const ReviewDocument(),
      ),
      GoRoute(
        path: '/addDocument',
        builder: (BuildContext context, GoRouterState state) =>
            const AddDocumentScreen(),
      ),
    ],
  );
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
