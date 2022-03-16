// ignore_for_file: avoid_redundant_argument_values

import 'package:document_review/app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

///Asked to document all public members.
class LoginScreen extends StatefulWidget {
  ///Asked to document all public members.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/books.jpeg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 60,
              horizontal: 20,
            ),
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
                        icon: visible == true
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
                      onPressed: () {},
                      child: const Text(
                        'Login',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
