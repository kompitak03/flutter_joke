import 'package:boardgame/jokes/joke.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jokeNotifierProvider =
    NotifierProvider<JokeNotifier, JokeState>(() => JokeNotifier());

class JokeNotifier extends Notifier<JokeState> {
  JokeRepository get _api => ref.read(repositoryProvider);

  @override
  JokeState build() => const JokeState();

  Future<void> loadJoke() async {
    try {

      final response = await _api.getJoke();

      state = state.copyWith(
        joke: response,
        loading: LoadingState.success,
      );
    } catch (_) {
      state = state.copyWith(
        loading: LoadingState.error,
      );
    }
  }

  void reloadJoke() {
    state = state.copyWith(
      loading: LoadingState.progress,
    );
    loadJoke();
  }
}
