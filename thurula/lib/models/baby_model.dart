class Baby {
  String? id;
  String? fname;
  String? lname;
  String? gender;
  DateTime? birthDate;
  List<String>? ownerIDs;

  Baby({
    this.id,
    this.fname,
    this.lname,
    this.gender,
    this.birthDate,
    this.ownerIDs,
  });


  static Baby fromJson(jsonDecode){
    return Baby(
      id: jsonDecode['id'],
      fname: jsonDecode['firstName'],
      lname: jsonDecode['lastName'],
      gender: jsonDecode['gender'],
      ownerIDs: jsonDecode['owners'].cast<String>(),
      birthDate: DateTime.parse(jsonDecode['birthDate']),
    );
  }

  static Map<String,dynamic> toJson(Baby baby){
    return{
      'id': baby.id,
      'firstName': baby.fname,
      'lastName': baby.lname,
      'gender': baby.gender,
      'birthDate': baby.birthDate?.toIso8601String(),
      'owners': baby.ownerIDs,
    };
  }


  @override
  String toString() {
    return 'Baby{name: $fname $lname}';
  }
}