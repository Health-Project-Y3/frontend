class FeedingTimes {
  String? id;
  String? babyId;
  DateTime? startTime = DateTime.now();
  DateTime? endTime = DateTime.now();
  String? feedingType;
  FeedingAmount? feedingAmount;
  String? feedingNotes;
  int? feedingMood;
  String? loggedBy;

  FeedingTimes({
    this.id = '',
    this.babyId = '',
    this.startTime,
    this.endTime,
    this.feedingType = '',
    this.feedingAmount,
    this.feedingNotes = '',
    this.feedingMood = 0,
    this.loggedBy = '',
  });

  static FeedingTimes fromJson(jsonDecode) {
    return FeedingTimes(
      id: jsonDecode['id'],
      babyId: jsonDecode['babyId'],
      //convert json string to DateTime eg. 2023-08-01T05:44:17.145Z
      startTime: DateTime.parse(jsonDecode['startTime']),
      endTime: DateTime.parse(jsonDecode['endTime']),
      feedingType: jsonDecode['feedingType'],
      feedingAmount: FeedingAmount(
        value: jsonDecode['feedingAmount']['value'],
        unit: jsonDecode['feedingAmount']['unit'],
      ),
      feedingNotes: jsonDecode['feedingNotes'],
      feedingMood: jsonDecode['feedingMood'],
      loggedBy: jsonDecode['loggedBy'],
    );
  }

  static Map<String, dynamic> toJson(FeedingTimes feedingTimes) {
    return {
      'id': feedingTimes.id,
      'babyId': feedingTimes.babyId,
      'startTime': feedingTimes.startTime.toString(),
      'endTime': feedingTimes.endTime.toString(),
      'feedingType': feedingTimes.feedingType,
      'feedingAmount': {
        'value': feedingTimes.feedingAmount!.value,
        'unit': feedingTimes.feedingAmount!.unit,
      },
      'feedingNotes': feedingTimes.feedingNotes,
      'feedingMood': feedingTimes.feedingMood,
      'loggedBy': feedingTimes.loggedBy,
    };
  }

  @override
  String toString() {
    return '\nFeedingTimes{id: $id, babyId: $babyId, startTime: $startTime, endTime: $endTime, feedingType: $feedingType, feedingAmount: $feedingAmount, feedingNotes: $feedingNotes, feedingMood: $feedingMood, loggedBy: $loggedBy}\n';
  }
}

class FeedingAmount {
  int? value = 0;
  String? unit = "";

  FeedingAmount({this.value, this.unit});
}
