// ignore_for_file: sort_constructors_first, prefer_int_literals

import 'package:document_review/app/models/document_model.dart';
import 'package:document_review/app/ui/home.dart';
import 'package:document_review/app/widgets/comment_widget.dart';
import 'package:flutter/material.dart';

///An enum to decide whether a document is passed or the user should ammend it.
// ignore: public_member_api_docs
enum Review { passed, ammend }
// ignore: public_member_api_docs

///[ReviewDocument] screen allows a user to review a document.
class ReviewDocument extends StatefulWidget {
  final DocumentModel documentModel;
  final Userm userm;
  const ReviewDocument(
      {Key? key, required this.documentModel, required this.userm})
      : super(key: key);

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
        child: SingleChildScrollView(
          child: widget.userm == Userm.user1
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
          onPressed: () {},
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
          'Rating: ${widget.documentModel.rating}',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Status: ${widget.documentModel.status}',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Comments: ',
          style: TextStyle(
            color: Colors.blueGrey.shade800,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        CommentWidget(
          userName: widget.documentModel.username!,
          comment: widget.documentModel.review!,
        ),
      ],
    );
  }
}
