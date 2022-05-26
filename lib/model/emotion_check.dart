class Emotion {
  final String emotion;

  const Emotion({required this.emotion});

  factory Emotion.fromJson(Map<String, dynamic> json) {
    return Emotion(emotion: json['emotion']);
  }
}
