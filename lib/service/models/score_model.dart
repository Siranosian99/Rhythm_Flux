class ScoreModel {
  String? userId;
  List<int>? score;


  ScoreModel(
      {required this.userId,required this.score});

  ScoreModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = userId;
    data['score'] = score;
    return data;
  }
}