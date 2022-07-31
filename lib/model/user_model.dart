// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  String email;
  String password;
  String walletAddress;
  bool isApproved;
  String screenShot;

  AppUser({
    required this.email,
    required this.password,
    required this.walletAddress,
    required this.isApproved,
    required this.screenShot,
  });

  AppUser copyWith({
    String? email,
    String? password,
    String? walletAddress,
    bool? isApproved,
    String? screenShot,
  }) {
    return AppUser(
      email: email ?? this.email,
      password: password ?? this.password,
      walletAddress: walletAddress ?? this.walletAddress,
      isApproved: isApproved ?? this.isApproved,
      screenShot: screenShot ?? this.screenShot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'walletAddress': walletAddress,
      'isApproved': isApproved,
      'screenShot': screenShot,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] as String,
      password: map['password'] as String,
      walletAddress: map['walletAddress'] as String,
      isApproved: map['isApproved'] as bool,
      screenShot: map['screenShot'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(email: $email, password: $password, walletAddress: $walletAddress, isApproved: $isApproved, screenShot: $screenShot)';
  }

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.walletAddress == walletAddress &&
        other.isApproved == isApproved &&
        other.screenShot == screenShot;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        walletAddress.hashCode ^
        isApproved.hashCode ^
        screenShot.hashCode;
  }
}
