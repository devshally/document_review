// ignore_for_file: avoid_redundant_argument_values

import 'package:document_review/app/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///[LoginScreen] is the first screen a user sees once the application starts.
class LoginScreen extends StatefulWidget {
  ///The constructor does not take any parameters.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///[TextEditingController] for the username.
  final TextEditingController usernameController = TextEditingController();

  ///[TextEditingController] for the password.
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///Initial bool value for password visibility.
  bool visible = true;

  // ignore: avoid_void_async
  void authenticateUser(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
            //Navigate to the home screen.
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  //Map string username to email.
  String mapUserToEmail(String username) {
    switch (username) {
      case 'User1':
        return 'user1@gmail.com';
      case 'User2':
        return 'user2@gmail.com';
      case 'User3':
        return 'user3@gmail.com';
      default:
        return '$username@gmail.com';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/books.jpeg',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/document.png',
                      height: 150,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'DOCUMENT-REVIEW',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF4B39EF),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFieldWidget(
                        controller: usernameController,
                        label: 'Username',
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: visible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        label: const Text(
                          'Password',
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: visible == false
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF4B39EF),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                        ),
                        onPressed: () {
                          authenticateUser(
                            mapUserToEmail(usernameController.text),
                            passwordController.text,
                          );
                        },
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
