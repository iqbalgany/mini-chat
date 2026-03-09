// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String uid;
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;
  UserModel({
    required this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImage,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      profileImage: map['profileImage'] != null
          ? map['profileImage'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, firstName: $firstName, lastName: $lastName, profileImage: $profileImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        profileImage.hashCode;
  }
}
