import 'package:document_review/app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///Custom widget used to display document data to users on the [HomeScreen].
class DocumentWidget extends StatelessWidget {
  ///The constructor will take a document model.
  const DocumentWidget({
    Key? key,
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
              children: const [
                Text(
                  'Title: Document Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Category: Category',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Status: Uploaded',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Uploaded by: User 3',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Date Uploaded: 30/03/22',
                  style: TextStyle(
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
