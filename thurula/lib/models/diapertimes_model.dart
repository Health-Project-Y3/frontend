class DiaperTimes {
  String? id;
  String? babyId;
  DateTime? time;
  String? diaperNotes;
  String? diaperType;
  String? loggedBy;

  DiaperTimes(
      {this.id = '',
      this.babyId = '',
      this.time,
      this.diaperNotes = '',
      this.diaperType,
      this.loggedBy = ''});

  static DiaperTimes fromJson(Map<String, dynamic> json) {
    return DiaperTimes(
      id: json['id'],
      babyId: json['babyId'],
      time: DateTime.parse(json['time']),
      diaperNotes: json['diaperNotes'],
      diaperType: json['diaperType'],
      loggedBy: json['loggedBy'],
    );
  }

  static Map<String, dynamic> toJson(DiaperTimes diaperTimes) {
    return {
      'id': diaperTimes.id,
      'babyId': diaperTimes.babyId,
      'time': diaperTimes.time.toString(),
      'diaperNotes': diaperTimes.diaperNotes,
      'diaperType': diaperTimes.diaperType,
      'loggedBy': diaperTimes.loggedBy,
    };
  }

  @override
  String toString() {
    return 'DiaperTimes{id: $id\n babyId: $babyId\n time: $time\n diaperNotes: $diaperNotes\n diaperType: $diaperType\n loggedBy: $loggedBy}\n';
  }


}
