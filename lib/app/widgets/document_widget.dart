import 'package:document_review/app/models/document_model.dart';
import 'package:document_review/app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///Custom widget used to display document data to users on the [HomeScreen].
class DocumentWidget extends StatelessWidget {
  ///The constructor will take a document model.
  final DocumentModel document;
  const DocumentWidget({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => context.push('/review'),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: ${document.title}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Category: ${document.category}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Status: ${document.status}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Uploaded by: ${document.username}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Date Uploaded: ${document.date}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
