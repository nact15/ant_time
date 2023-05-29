import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'commentary_event.dart';

part 'commentary_state.dart';

class CommentaryBloc extends Bloc<CommentaryEvent, CommentaryState> {

  CommentaryBloc() : super(CommentaryState(status: CommentaryStatus.initial)) {
    on<CommentarySend>((event, emit) {
      try {

      } catch (_) {

      }
    });
  }
}
