import 'dart:convert';

import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final int? id;
  final String? username;
  final String? title;
  final String? description;
  final String? category;
  final String? status;
  final String? review;
  final String? rating;
  final String? document;
  final String? date;

  const Document(
      this.id,
      this.username,
      this.title,
      this.description,
      this.category,
      this.status,
      this.review,
      this.rating,
      this.document,
      this.date);

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
        date
      ];

  Map<String, dynamic> toMap() {
    return {
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

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      map['id']?.toInt(),
      map['username'],
      map['title'],
      map['description'],
      map['category'],
      map['status'],
      map['review'],
      map['rating'],
      map['document'],
      map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source));
}
