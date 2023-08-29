import 'package:boardgame/jokes/models/joke_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositoryProvider = Provider<JokeRepository>((_) => JokeRepository());

class JokeRepository {
  final _client = Dio(
    BaseOptions(baseUrl: "https://official-joke-api.appspot.com"),
  );

  Future<Joke> getJoke() async {
    final result = await _client.get('/random_joke');
    final Joke joke = Joke.fromJson(result.data);
    return joke;
  }
}
