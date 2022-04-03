import 'package:document_review/app/features/DocumentReview/presentation/cubit/documentreview_cubit.dart';
import 'package:document_review/app/features/DocumentReview/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;

  ///Function to return a user email from the username.
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
      body: BlocConsumer<DocumentreviewCubit, DocumentreviewState>(
        listener: (context, state) {
          if (state is UserAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  userEmail: usernameController.text,
                ),
              ),
            );
          } else if (state is DocumentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildBody();
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
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
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        labelText: 'Username',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscure,
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
                            obscure = !obscure;
                          });
                        },
                        icon: obscure == false
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
                        BlocProvider.of<DocumentreviewCubit>(context)
                            .signInUser(
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
    );
  }
}
