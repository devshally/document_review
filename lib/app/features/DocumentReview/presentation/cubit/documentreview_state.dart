part of 'documentreview_cubit.dart';

abstract class DocumentreviewState extends Equatable {
  const DocumentreviewState();

  @override
  List<Object> get props => [];
}

class DocumentInitial extends DocumentreviewState {}

class DocumentLoading extends DocumentreviewState {}

class DocumentRetrieved extends DocumentreviewState {
  final List<Document> documents;

  const DocumentRetrieved(
    this.documents,
  );

  @override
  List<Object> get props => [documents];
}

class DocumentUploaded extends DocumentreviewState {
  final String url;

  const DocumentUploaded(this.url);
}

class DocumentSuccessful extends DocumentreviewState {}

class DocumentDownloaded extends DocumentreviewState {
  final String savedUrl;

  const DocumentDownloaded(this.savedUrl);
}

class DocumentError extends DocumentreviewState {
  final String message;

  const DocumentError(this.message);
}

class UserAuthenticated extends DocumentreviewState {
  final String userEmail;

  const UserAuthenticated(this.userEmail);
}

class UserError extends DocumentreviewState {
  final String message;

  const UserError(this.message);
}
