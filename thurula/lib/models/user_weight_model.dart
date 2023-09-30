class UserWeight {
  String? id;
  String? userId;
  double? weight;
  DateTime? date;

  UserWeight({
    this.id,
    this.userId,
    this.weight,
    this.date,
  });

  static UserWeight fromJson(jsonDecode){
    return UserWeight(
      id: jsonDecode['id'],
      userId: jsonDecode['userId'],
      weight: jsonDecode['weight'],
      date: DateTime.parse(jsonDecode['date']),
    );
  }

  static Map<String,dynamic> toJson(UserWeight uwr){
    return{
      if(uwr.id != null) 'id': uwr.id,
      'userId': uwr.userId,
      'weight': uwr.weight,
      'date': uwr.date?.toIso8601String(),
    };
  }


  @override
  String toString() {
    return '{user: $userId, date: $date, weight: $weight}';
  }
}