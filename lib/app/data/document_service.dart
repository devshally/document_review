// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:document_review/app/models/document_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DocumentService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> addDocument(File filePath, String docName) async {
    try {
      final ref = _storage.ref().child('documents/$docName');
      final uploadTask = ref.putFile(filePath);
      final downloadUrl = await uploadTask;

      final url = await downloadUrl.ref.getDownloadURL();
      return url;
    } catch (e) {
      rethrow;
    }
  }

  void uploadDocument({
    required String username,
    required String title,
    required String description,
    required String category,
    required String document,
  }) async {
    final dio = Dio();
    final time = DateTime.now();
    try {
      await dio.post(
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
    } catch (e) {
      print(e);
    }
  }

  Future<List<DocumentModel>> getDocuments() async {
    final dio = Dio();
    final response = await dio.get(
        'https://budgetmental-austriagenesis-8080.codio-box.uk/api/v2/documents');
    if (response.statusCode == 200) {
      final List<DocumentModel> documents =
          response.data["documents"].map<DocumentModel>((document) {
        return DocumentModel.fromJson(document);
      }).toList();
      return documents;
    } else {
      throw Exception('Failed to load documents');
    }
  }
}
