class User {
  String username;
  String token;

  User({required this.username, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{username: $username, token: $token}';
  }
}
