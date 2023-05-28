class WordTranslation {
  final int? id;
  final String slovo;
  final String? perevod;

  WordTranslation({this.id, required this.slovo, this.perevod});

  factory WordTranslation.fromMap(Map<String, dynamic> json) => WordTranslation(
    id: json['_id'],
    slovo: json['slovo'],
    perevod: json['perevod'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': slovo,
      'perevod': perevod,
    };
  }
}