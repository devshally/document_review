import 'dart:io';

import 'package:document_review/app/features/DocumentReview/domain/entities/document.dart';
import 'package:document_review/app/features/DocumentReview/presentation/cubit/documentreview_cubit.dart';
import 'package:document_review/app/features/DocumentReview/presentation/pages/home.dart';
import 'package:document_review/app/features/DocumentReview/presentation/pages/view_pdf.dart';
import 'package:document_review/app/features/DocumentReview/presentation/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class ReviewScreen extends StatefulWidget {
  final Document document;
  final Userm userm;
  const ReviewScreen({Key? key, required this.document, required this.userm})
      : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

enum Review { passed, ammend }

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController commentController = TextEditingController();
  Review _review = Review.passed;
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text(widget.document.title!),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<DocumentreviewCubit>(context).getDocuments();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: BlocConsumer<DocumentreviewCubit, DocumentreviewState>(
        listener: (context, state) {
          if (state is DocumentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is DocumentSuccessful) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document graded successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is DocumentDownloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document downloaded successfully to files.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: widget.userm == Userm.user1
                ? _buildUserOneBody()
                : _buildOtherUserBody(),
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    return Center(
      child: Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          image: const DecorationImage(
            image: AssetImage('assets/images/pdf.png'),
          ),
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
          children: [
            GestureDetector(
              onTap: () {
                getFilePath().then((value) =>
                    BlocProvider.of<DocumentreviewCubit>(context)
                        .downloadDocument(widget.document.document!, value));
              },
              child: const Text(
                'Download',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewPdf(
                        url: widget.document.document!,
                        title: widget.document.title!,
                      ),
                    ),
                  )),
              child: const Text(
                'View',
                style: TextStyle(
                  fontSize: 16,
                ),
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
            controller: commentController,
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
            BlocProvider.of<DocumentreviewCubit>(context).putReviewAndRating(
              id: widget.document.id.toString(),
              review: commentController.text,
              rating: _value.toString(),
              status: _review.name,
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget _buildUserOneBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
      ),
    );
  }

  Widget _buildOtherUserBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Text(
            'Rating: ${widget.document.rating}',
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Status: ${widget.document.status}',
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
            userName: widget.document.username!,
            comment: widget.document.review!,
          ),
        ],
      ),
    );
  }

  Future<String> getFilePath() async {
    String path = "";

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/${widget.document.title}';

    return path;
  }
}
