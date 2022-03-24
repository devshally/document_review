// ignore_for_file: sort_constructors_first, prefer_int_literals

import 'package:document_review/app/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///An enum to decide whether a document is passed or the user should ammend it.
// ignore: public_member_api_docs
enum Review { passed, ammend }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: const Text('TITLE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: _buildBody(context)),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: style,
              ),
              Text(
                'Download',
                style: style,
              ),
              Text(
                'Status',
                style: style,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.black,
        ),
        _buildReview(context),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      height: 400,
      width: double.maxFinite,
      color: Colors.blueGrey.shade100,
      child: Icon(
        Icons.photo_size_select_actual_outlined,
        size: 250,
        color: Colors.blueGrey.shade200,
      ),
    );
  }

  // ignore: unused_element
  Widget _buildComments() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comment(s)',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          const CommentWidget(),
        ],
      ),
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
        ElevatedButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
