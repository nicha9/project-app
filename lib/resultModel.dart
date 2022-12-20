class Item {
  final String date;
  final String id;
  final String result_image;
  final int score;
  final int trial;

  Item({
    required this.date,
    required this.id,
    required this.result_image,
    required this.score,
    required this.trial,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'id': id,
    'result_image': result_image,
    'score': score,
    'trial': trial
  };

  static Item fromJson(Map<String, dynamic> json) => Item(
      date: json['date'],
      id: json['id'],
      result_image: json['result_image'],
      score: json['score'],
      trial: json['trial']
  );
}