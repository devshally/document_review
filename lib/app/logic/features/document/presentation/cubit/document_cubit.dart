// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ntp/ntp.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> addDocument(File filePath, String docName) async {
    try {
      final ref = _storage.ref().child('documents/$docName');
      final uploadTask = ref.putFile(filePath);
      final downloadUrl = await uploadTask;

      final url = await downloadUrl.ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future uploadDocument({
    required String username,
    required String title,
    required String description,
    required String category,
    required String document,
  }) async {
    final dio = Dio();
    final time = NTP.now();
    await dio.post(
      'https://budgetmental-austriagenesis-8080.codio-box.uk/api/v2/documents',
      data: <String, dynamic>{
        "username": username,
        "title": title,
        "description": description,
        "category": category,
        "status": "uploaded",
        "document": document,
        "date": time,
      },
    );
  }
}
