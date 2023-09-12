class UserExercise {
  String? id;
  String? userId;
  int? minutesExercised;
  DateTime? date;

  UserExercise({
    this.id,
    this.userId,
    this.minutesExercised,
    this.date,
  });

  static UserExercise fromJson(jsonDecode){
    return UserExercise(
      id: jsonDecode['id'],
      userId: jsonDecode['userId'],
      minutesExercised: jsonDecode['minutesExercised'],
      date: DateTime.parse(jsonDecode['date']),
    );
  }

  static Map<String,dynamic> toJson(UserExercise ex){
    return{
      'id': ex.id,
      'userId': ex.userId,
      'minutesExercised': ex.minutesExercised,
      'date': ex.date?.toIso8601String(),
    };
  }


  @override
  String toString() {
    return '{user: $userId, date: $date, minutes: $minutesExercised}';
  }
}