import 'package:boardgame/jokes/api/joke_repository.dart';
import 'package:boardgame/jokes/joke.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jokeFutureProvider = FutureProvider<Joke>((ref) {
  final repository = ref.read(repositoryProvider);
  return repository.getJoke();
});
