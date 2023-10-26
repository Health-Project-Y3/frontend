class NapTimes {
  String? id;
  String? babyId;
  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now();
  String? sleepNotes;
  int? sleepQuality;
  String? loggedBy;

  NapTimes({
    this.id = '',
    this.babyId = '',
    this.startTime,
    this.endTime,
    this.sleepNotes = '',
    this.sleepQuality = 0,
    this.loggedBy = '',
  });

  static NapTimes fromJson(jsonDecode) {
    return NapTimes(
      id: jsonDecode['id'],
      babyId: jsonDecode['babyId'],
      //convert json string to DateTime eg. 2023-08-01T05:44:17.145Z
      startTime: DateTime.parse(jsonDecode['startTime']),
      endTime: DateTime.parse(jsonDecode['endTime']),
      sleepNotes: jsonDecode['sleepNotes'],
      sleepQuality: jsonDecode['sleepQuality'],
      loggedBy: jsonDecode['loggedBy'],
    );
  }

  static Map<String, dynamic> toJson(NapTimes napTimes) {
    return {
      'id': napTimes.id,
      'babyId': napTimes.babyId,
      'startTime': napTimes.startTime?.toIso8601String(),
      'endTime': napTimes.endTime?.toIso8601String(),
      'sleepNotes': napTimes.sleepNotes,
      'sleepQuality': napTimes.sleepQuality,
      'loggedBy': napTimes.loggedBy,
    };
  }

  static int getNapDuration(NapTimes napTimes) {
    return napTimes.endTime!.difference(napTimes.startTime!).inMinutes;
  }

  @override
  String toString() {
    return 'NapTimes{id: $id \n babyId: $babyId \n startTime: $startTime \n endTime: $endTime \n sleepNotes: $sleepNotes \n sleepQuality: $sleepQuality \n loggedBy: $loggedBy}';
  }
}
