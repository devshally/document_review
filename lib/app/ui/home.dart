import 'package:document_review/app/widgets/document_widget.dart';
import 'package:document_review/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';

///This is the beginning of the app.
class HomeScreen extends StatelessWidget {
  ///Nothing declared in the constructor yet.
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My Documents',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                letterSpacing: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: SearchWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: const [
          DocumentWidget(),
        ],
      ),
    );
  }
}
