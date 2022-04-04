import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:document_review/app/features/DocumentReview/domain/entities/document.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'documentreview_state.dart';

class DocumentreviewCubit extends Cubit<DocumentreviewState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Dio _dio = Dio();
  DocumentreviewCubit() : super(DocumentInitial());

  void signInUser(String email, String password) async {
    emit(DocumentLoading());
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(UserAuthenticated(user.user!.email!));
    } on FirebaseAuthException catch (e) {
      emit(DocumentError(e.toString()));
    }
  }

  void signOutUser() async {
    try {
      await _auth.signOut();
      emit(DocumentInitial());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void storeDocument(File filePath, String docName) async {
    emit(DocumentLoading());
    try {
      final ref = _storage.ref().child('documents/$docName');
      final uploadTask = ref.putFile(filePath);
      final downloadUrl = await uploadTask;

      final url = await downloadUrl.ref.getDownloadURL();
      emit(DocumentUploaded(url));
    } on FirebaseException catch (e) {
      emit(DocumentError(e.toString()));
    }
  }

  void uploadDocument({
    required String username,
    required String title,
    required String description,
    required String category,
    required String document,
  }) async {
    emit(DocumentLoading());
    try {
      final time = DateTime.now();
      await _dio.post(
        'https://budgetmental-austriagenesis-8080.codio-box.uk/api/v2/post',
        queryParameters: {
          "username": username,
          "title": title,
          "description": description,
          "category": category,
          "status": "uploaded",
          "review": "",
          "rating": "",
          "document": document,
          "date": time.toString(),
        },
      );
      emit(DocumentSuccessful());
    } on DioError catch (e) {
      emit(DocumentError(e.toString()));
    }
  }

  void getDocuments() async {
    emit(DocumentLoading());
    try {
      final documents = await _dio.get(
        'https://budgetmental-austriagenesis-8080.codio-box.uk/api/v2/documents',
      );
      List<Document> documentsList = documents.data["documents"]
          .map<Document>((document) => Document.fromJson(document))
          .toList();
      emit(DocumentRetrieved(documentsList));
    } on DioError catch (e) {
      emit(DocumentError(e.toString()));
    }
  }

  void putReviewAndRating({
    required String id,
    required String review,
    required String rating,
    required String status,
  }) async {
    emit(DocumentLoading());
    try {
      await _dio.put(
        'https://budgetmental-austriagenesis-8080.codio-box.uk/api/v2/documents/$id',
        queryParameters: {
          "review": review,
          "rating": rating,
          "status": status,
        },
      );
      emit(DocumentSuccessful());
    } on DioError catch (e) {
      emit(DocumentError(e.toString()));
    }
  }
}
