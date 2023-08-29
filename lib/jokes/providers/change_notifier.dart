import 'package:boardgame/jokes/joke.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jokeCNProvider = ChangeNotifierProvider((ref) => JokeChangeNotifier(ref));

enum LoadingState { progress, success, error }

class JokeChangeNotifier extends ChangeNotifier {
  JokeChangeNotifier(Ref ref) : _api = ref.read(repositoryProvider);

  final JokeRepository _api;
  Joke joke = const Joke(id: 1, type: 'general', setup: 'ha', punchline: 'ha ha ha');
  LoadingState loading = LoadingState.progress;

  void reloadJoke() {
    loading = LoadingState.progress;
    notifyListeners();

    loadJoke();
  }

  Future<void> loadJoke() async {
    try {
      final response = await _api.getJoke();
      joke = response;
      loading = LoadingState.success;
    } catch (_) {
      loading = LoadingState.error;
    }
    notifyListeners();
  }
}
