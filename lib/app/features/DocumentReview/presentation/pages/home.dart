import 'package:document_review/app/features/DocumentReview/domain/entities/document.dart';
import 'package:document_review/app/features/DocumentReview/presentation/cubit/documentreview_cubit.dart';
import 'package:document_review/app/features/DocumentReview/presentation/pages/add_document.dart';
import 'package:document_review/app/features/DocumentReview/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;
  const HomeScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Userm { user1, user2, user3 }

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

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DocumentreviewCubit>(context).getDocuments();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Documents',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    letterSpacing: 1,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    BlocProvider.of<DocumentreviewCubit>(context).signOutUser();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Padding(
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
                user: returnUser(widget.userEmail),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
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
          }
        },
        builder: (context, state) {
          if (state is DocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DocumentRetrieved) {
            return ListView.builder(itemBuilder: ((context, index) {
              List<Document> documents = state.documents;
              return ListTile(
                title: Text(documents[index].title!),
                subtitle: Text(documents[index].description!),
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ReviewDocumentScreen(
                  //       document: state.documents[index],
                  //       userm: returnUser(userEmail),
                  //     ),
                  //   ),
                  // );
                },
              );
            }));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No documents found',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildBody() {
  //   return FutureBuilder(
  //     future: BlocProvider.of<DocumentreviewCubit>(context).getDocuments(),
  //     builder: ((context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         if (snapshot.hasError) {
  //           return const Center(
  //             child: Text('Error: Something went wrong, please try again'),
  //           );
  //         }
  //         final List<DocumentModel> documents =
  //             snapshot.data as List<DocumentModel>;
  //         return SizedBox(
  //           height: MediaQuery.of(context).size.height,
  //           child: ListView.builder(
  //             itemCount: documents.length,
  //             itemBuilder: ((context, index) {
  //               return DocumentWidget(
  //                 document: documents[index],
  //                 userm: returnUser(userEmail),
  //               );
  //             }),
  //           ),
  //         );
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     }),
  //   );
  // }
}
