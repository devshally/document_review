// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

///The [DocumentModel] is the model used to store the data for a document.
class DocumentModel extends Equatable {
  final int id;
  final String username;
  final String title;
  final String description;
  final String category;
  final String status;
  final String review;
  final String rating;
  final String? document;
  final String? date;

  const DocumentModel({
    required this.id,
    required this.username,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.review,
    required this.rating,
    required this.document,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        title,
        description,
        category,
        status,
        review,
        rating,
        document,
        date,
      ];

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] as int,
      username: json['username'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      status: json['status'],
      review: json['review'],
      rating: json['rating'],
      document: json['document'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'review': review,
      'rating': rating,
      'document': document,
      'date': date,
    };
  }
}
