// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String profilePicture;
  String phoneNumber;
  String password;
  String uid;
  String email;
  String streaks;
  UserModel({
    required this.name,
    required this.profilePicture,
    required this.phoneNumber,
    required this.password,
    required this.uid,
    required this.email,
    required this.streaks,
  });

  UserModel copyWith({
    String? name,
    String? profilePicture,
    String? phoneNumber,
    String? password,
    String? uid,
    String? email,
    String? streaks,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      streaks: streaks ?? this.streaks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePicture': profilePicture,
      'phoneNumber': phoneNumber,
      'password': password,
      'uid': uid,
      'email': email,
      'streaks': streaks,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePicture: map['profilePicture'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
      streaks: map['streaks'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, profilePicture: $profilePicture, phoneNumber: $phoneNumber, password: $password, uid: $uid, email: $email, streaks: $streaks)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profilePicture == profilePicture &&
        other.phoneNumber == phoneNumber &&
        other.password == password &&
        other.uid == uid &&
        other.email == email &&
        other.streaks == streaks;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePicture.hashCode ^
        phoneNumber.hashCode ^
        password.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        streaks.hashCode;
  }
}
