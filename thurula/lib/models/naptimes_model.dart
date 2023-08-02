class NapTimes {
  String? id;
  String? babyId;
  DateTime? startTime;
  DateTime? endTime;
  String? sleepNotes;
  int? sleepQuality;
  String? loggedBy;

  NapTimes({
    this.id,
    this.babyId,
    this.startTime,
    this.endTime,
    this.sleepNotes,
    this.sleepQuality,
    this.loggedBy,
  });

  static NapTimes fromJson(jsonDecode) {
    return NapTimes(
      id: jsonDecode['id'],
      babyId: jsonDecode['babyId'],
      startTime: jsonDecode['startTime'],
      endTime: jsonDecode['endTime'],
      sleepNotes: jsonDecode['sleepNotes'],
      sleepQuality: jsonDecode['sleepQuality'],
      loggedBy: jsonDecode['loggedBy'],
    );
  }
}
