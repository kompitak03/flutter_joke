import 'package:boardgame/jokes/api/joke_repository.dart';
import 'package:boardgame/jokes/models/joke_model.dart';
import 'package:boardgame/jokes/providers/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final JokeStateProvider = StateNotifierProvider<JokeStateNotifier, JokeState>(
  (ref) => JokeStateNotifier(ref),
);

@immutable
class JokeState {
  const JokeState({
    this.joke = const Joke(
      id: 1,
      type: 'general',
      setup: 'ha',
      punchline: 'ha ha ha',
    ),
    this.loading = LoadingState.progress,
  });

  final Joke joke;
  final LoadingState loading;

  JokeState copyWith({
    Joke? joke,
    LoadingState? loading,
  }) =>
      JokeState(
        joke: joke ?? this.joke,
        loading: loading ?? this.loading,
      );
}

class JokeStateNotifier extends StateNotifier<JokeState> {
  JokeStateNotifier(Ref ref)
      : _api = ref.read(repositoryProvider),
        super(const JokeState());

  final JokeRepository _api;

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

  Future<void> reloadJoke() async {
    state = state.copyWith(
      loading: LoadingState.progress,
    );
    loadJoke();
  }
}
