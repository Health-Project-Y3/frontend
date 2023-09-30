class UserDrinking {
  String? id;
  String? userId;
  int? glassesDrunk;
  DateTime? date;

  UserDrinking({
    this.id,
    this.userId,
    this.glassesDrunk,
    this.date,
  });

  static UserDrinking fromJson(jsonDecode){
    return UserDrinking(
      id: jsonDecode['id'],
      userId: jsonDecode['userId'],
      glassesDrunk: jsonDecode['glassesDrunk'],
      date: DateTime.parse(jsonDecode['date']),
    );
  }

  static Map<String,dynamic> toJson(UserDrinking udr){
    return{
      if(udr.id != null) 'id': udr.id,
      'userId': udr.userId,
      'glassesDrunk': udr.glassesDrunk,
      'date': udr.date?.toIso8601String(),
    };
  }


  @override
  String toString() {
    return '{user: $userId, date: $date, glasses: $glassesDrunk}';
  }
}