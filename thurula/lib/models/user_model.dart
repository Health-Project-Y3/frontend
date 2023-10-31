class User {
  String? id;
  String? username;
  String? token;
  String? fname;
  String? lname;
  String? gender;
  String? email;
  String? phone;
  double? weight;
  double? preWeight;
  double? height;
  bool? pregnant;
  DateTime? dueDate;
  DateTime? conceptionDate;
  List<String>? babyIDs;

  User({
    this.id,
    this.username,
    this.token,
    this.fname,
    this.lname,
    this.gender,
    this.email,
    this.phone,
    this.weight,
    this.preWeight,
    this.height,
    this.pregnant,
    this.dueDate,
    this.conceptionDate,
    this.babyIDs,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'token': token,
    };
  }

  static User fromJson(jsonDecode){
    return User(
      id: jsonDecode['id'],
      username: jsonDecode['username'],
      fname: jsonDecode['firstName'],
      lname: jsonDecode['lastName'],
      gender: jsonDecode['gender'],
      email: jsonDecode['email'],
      babyIDs: jsonDecode['babies'].cast<String>(),
      phone: jsonDecode['phone'],
      weight: jsonDecode['weight'],
      preWeight: jsonDecode['preWeight'],
      height: jsonDecode['height'],
      pregnant: jsonDecode['pregnant'],
      dueDate: DateTime.parse(jsonDecode['dueDate']),
      conceptionDate:DateTime.parse(jsonDecode['conceptionDate'])
    );
  }

  static Map<String,dynamic> toJson(User user){
    return{
      'id': user.id,
      'username': user.username,
      'firstName': user.fname,
      'lastName': user.lname,
      'gender': user.gender,
      'email': user.email,
      'phone': user.phone,
      'weight': user.weight,
      'preWeight': user.preWeight,
      'height': user.height,
      'pregnant': user.pregnant,
      'dueDate': user.dueDate?.toIso8601String(),
      'conceptionDate': user.conceptionDate?.toIso8601String(),
      'babies': user.babyIDs,
    };
  }



  @override
  String toString() {
    return 'User{username: $username, token: $token}';
  }
}