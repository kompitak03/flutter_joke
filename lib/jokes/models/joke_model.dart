class Joke {
  final int id;
  final String type;
  final String setup;
  final String punchline;

  factory Joke.fromJson(Map<String, dynamic> json) => Joke(
        id: json['id'],
        type: json['type'],
        setup: json['setup'],
        punchline: json['punchline'],
      );

  const Joke({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });
}
