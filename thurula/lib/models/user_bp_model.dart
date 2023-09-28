class UserBp {
  String? id;
  String? userId;
  double? bloodPressure;
  DateTime? date;

  UserBp({
    this.id,
    this.userId,
    this.bloodPressure,
    this.date,
  });

  static UserBp fromJson(jsonDecode){
    return UserBp(
      id: jsonDecode['id'],
      userId: jsonDecode['userId'],
      bloodPressure: jsonDecode['bloodPressure'],
      date: DateTime.parse(jsonDecode['date']),
    );
  }

  static Map<String,dynamic> toJson(UserBp bpr){
    return{
      'id': bpr.id,
      'userId': bpr.userId,
      'bloodPressure': bpr.bloodPressure,
      'date': bpr.date?.toIso8601String(),
    };
  }


  @override
  String toString() {
    return '{user: $userId, date: $date, bp: $bloodPressure}';
  }
}