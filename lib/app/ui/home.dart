import 'package:document_review/app/logic/features/document/presentation/cubit/document_service.dart';
import 'package:document_review/app/models/document_model.dart';
import 'package:document_review/app/widgets/document_widget.dart';
import 'package:document_review/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[HomeScreen] is the beginning of the app once a user is logged in.
class HomeScreen extends StatelessWidget {
  ///The constructor does not take any parameters.
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
        onPressed: () {
          context.push('/addDocument');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildBody(),
        ),
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
          final List<DocumentModel> authors =
              snapshot.data as List<DocumentModel>;
          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: ((context, index) {
              return const DocumentWidget();
            }),
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
