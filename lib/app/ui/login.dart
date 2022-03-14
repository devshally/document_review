import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/document.png",
                height: 150.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "DOCUMENT-REVIEW",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF4B39EF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Username",
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: visible,
                decoration: InputDecoration(
                  label: const Text(
                    "Password",
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
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
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF4B39EF),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 50.0)),
                  onPressed: () {},
                  child: const Text(
                    "Login",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
