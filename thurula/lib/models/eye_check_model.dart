class EyeCheck {
  String? id;
  String? babyId;
  DateTime? checkedDate;
  int? score;

  EyeCheck({this.id, this.babyId, this.checkedDate, this.score});
  static EyeCheck fromJson(jsonDecode) {
    return EyeCheck(
      id: jsonDecode['id'],
      babyId: jsonDecode['babyId'],
      checkedDate: jsonDecode['checkedDate'] != null
        ? DateTime.parse(jsonDecode['checkedDate'])
        : null,
      score: jsonDecode['score'],
    );
  }

  static Map<String, dynamic> toJson(EyeCheck eyecheck) {
    return {
      'id': eyecheck.id,
      'babyId': eyecheck.babyId,
      'checkedDate': eyecheck.checkedDate,
      'score': eyecheck.score,
    };
  }

  @override
  String toString() {
    return 'Eye Check{id: $id, babyId: $babyId, checkedDate: $checkedDate, score: $score}\n';
  }
}
