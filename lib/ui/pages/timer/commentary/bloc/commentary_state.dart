part of 'commentary_bloc.dart';

enum CommentaryStatus {
  initial,
  shouldClear,
  loading,
  success,
  error,
}

class CommentaryState {
  final CommentaryStatus status;
  final String errorTitle;

  CommentaryState({
    required this.status,
    this.errorTitle = '',
  });
}
