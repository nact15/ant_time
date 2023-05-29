part of 'commentary_bloc.dart';

@immutable
abstract class CommentaryEvent {}

class CommentarySend extends CommentaryEvent {
  final String commentary;

  CommentarySend(this.commentary);
}