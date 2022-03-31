// ignore_for_file: public_member_api_docs, comment_references

import 'package:flutter/material.dart';

///Custom widget used on [ReviewDocument] to capture a users comment.
class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: TextStyle(
                color: Colors.indigo.shade800,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Comment lorem ipsum ni cali se tai ma can ji fong long teng jai out eininv fcei viv vnw ivr fenj.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
