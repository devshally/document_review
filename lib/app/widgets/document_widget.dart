import 'package:document_review/app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///Custom widget used to display document data to users on the [HomeScreen].
class DocumentWidget extends StatelessWidget {
  ///The constructor takes the document title and date.
  const DocumentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/review'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 2, color: Colors.grey.shade300),
            bottom: BorderSide(width: 2, color: Colors.grey.shade300),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                child: Icon(Icons.paste_sharp),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Document 1',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '03/03/22',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}