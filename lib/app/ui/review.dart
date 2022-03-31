// ignore_for_file: sort_constructors_first, prefer_int_literals

import 'package:document_review/app/widgets/comment_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///An enum to decide whether a document is passed or the user should ammend it.
// ignore: public_member_api_docs
enum Review { passed, ammend }
// ignore: public_member_api_docs
enum Userm { user1, user2, user3 }

///[ReviewDocument] screen allows a user to review a document.
class ReviewDocument extends StatefulWidget {
  ///The constructor does not take any parameters.
  const ReviewDocument({Key? key}) : super(key: key);

  @override
  State<ReviewDocument> createState() => _ReviewDocumentState();
}

class _ReviewDocumentState extends State<ReviewDocument> {
  Review _review = Review.passed;
  double _value = 0.0;
  final TextStyle style = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final TextEditingController descriptionController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String userEmail = '';

  // ignore: avoid_void_async
  void getCurrentUser() async {
    // ignore: await_only_futures
    final user = await _auth.currentUser!.email;
    setState(() {
      userEmail = user!;
    });
  }

  //Get the current user and map it to Userm.
  Userm returnUser(String userEmail) {
    switch (userEmail) {
      case 'user1@gmail.com':
        return Userm.user1;
      case 'user2@gmail.com':
        return Userm.user2;
      case 'user3@gmail.com':
        return Userm.user3;
      default:
        return Userm.user1;
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text('TITLE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: returnUser(userEmail) == Userm.user1
              ? _buildUserOneBody()
              : _buildOtherUserBody(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Center(
      child: Container(
        height: 250,
        width: 200,
        color: Colors.blueGrey.shade100,
        child: Icon(
          Icons.photo_size_select_actual_outlined,
          size: 100,
          color: Colors.blueGrey.shade200,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        _buildImage(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Download',
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'View',
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///Function used to build review with slider.
  Widget _buildReview(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SliderTheme(
            data: SliderThemeData(
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              max: 5.0,
              divisions: 5,
              value: _value,
              onChanged: (newValue) {
                setState(() {
                  _value = newValue;
                });
              },
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: const Text('Passed'),
          leading: Radio(
            value: Review.passed,
            groupValue: _review,
            onChanged: (Review? value) {
              setState(() {
                _review = value!;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: const Text('Ammend'),
          leading: Radio(
            value: Review.ammend,
            groupValue: _review,
            onChanged: (Review? value) {
              setState(() {
                _review = value!;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add comment',
            ),
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget _buildUserOneBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        Text(
          'Rate this document:',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        _buildReview(context),
      ],
    );
  }

  Widget _buildOtherUserBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 20),
        Text(
          'Rating: 4',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Status: Passed',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Comments:',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        const CommentWidget(),
      ],
    );
  }
}
