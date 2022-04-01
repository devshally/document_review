import 'package:document_review/app/data/document_service.dart';
import 'package:document_review/app/models/document_model.dart';
import 'package:document_review/app/ui/add_document.dart';
import 'package:document_review/app/widgets/document_widget.dart';
import 'package:document_review/app/widgets/search_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///[HomeScreen] is the beginning of the app once a user is logged in.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Userm { user1, user2, user3 }

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  String userEmail = '';
  void getCurrentUser() async {
    final user = _auth.currentUser!.email;
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddDocumentScreen(
                userm: returnUser(userEmail),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final DocumentService documentService = DocumentService();
    return FutureBuilder(
      future: documentService.getDocuments(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error: Something went wrong, please try again'),
            );
          }
          final List<DocumentModel> documents =
              snapshot.data as List<DocumentModel>;
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: ((context, index) {
                return DocumentWidget(
                  document: documents[index],
                  userm: returnUser(userEmail),
                );
              }),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
