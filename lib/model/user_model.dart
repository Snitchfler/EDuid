

class UserModel {
  String? uid;
  String? email;
  String? password;
  String? confirmPassword;
  String? username;

  UserModel({this.uid, this.email, this.username});

  factory UserModel.fromMapMap(map) {
    return UserModel(
        uid: map['uid'], email: map['email'], username: map['username']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}
