class WordTranslation {
  final int? id;
  final String slovo;
  final String? perevod;
  final int? lang;

  WordTranslation({this.id, required this.slovo, this.perevod, this.lang});

  factory WordTranslation.fromMap(Map<String, dynamic> json) => WordTranslation(
    id: json['_id'],
    slovo: json['slovo'],
    perevod: json['perevod'],
    lang: json['type'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slovo': slovo,
      'lang': lang,
    };
  }
}