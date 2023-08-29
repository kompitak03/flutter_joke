import 'package:boardgame/jokes/joke.dart';
import 'package:boardgame/jokes/providers/change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JokeApp extends ConsumerStatefulWidget {
  const JokeApp({required this.title, super.key});

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JokeAppState();
}

class _JokeAppState extends ConsumerState<JokeApp> {
  @override
  void initState() {
    super.initState();
    ref.read(JokeStateProvider.notifier).loadJoke();
  }

  @override
  Widget build(BuildContext context) {
    final joke = ref.watch(JokeStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: joke.loading == LoadingState.progress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : joke.loading == LoadingState.error
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Problem loading joke'),
                      const SizedBox(
                        height: 15,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          ref.read(JokeStateProvider.notifier).reloadJoke();
                        },
                        child: const Text('Try again'),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        joke.joke.setup,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(joke.joke.punchline),
                      const SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          ref.read(JokeStateProvider.notifier).reloadJoke();
                        },
                        child: const Text('Give me more'),
                      )
                    ],
                  ),
                ),
    );
  }
}
