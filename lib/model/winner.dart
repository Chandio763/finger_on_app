// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Winner {
  String email;
  String walletAddress;
  bool isPaid;
  Winner({
    required this.email,
    required this.walletAddress,
    required this.isPaid,
  });

  Winner copyWith({
    String? email,
    String? walletAddress,
    bool? isPaid,
  }) {
    return Winner(
      email: email ?? this.email,
      walletAddress: walletAddress ?? this.walletAddress,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'walletAddress': walletAddress,
      'isPaid': isPaid,
    };
  }

  factory Winner.fromMap(Map<String, dynamic> map) {
    return Winner(
      email: map['email'] as String,
      walletAddress: map['walletAddress'] as String,
      isPaid: map['isPaid'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Winner.fromJson(String source) =>
      Winner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Winner(email: $email, walletAddress: $walletAddress, isPaid: $isPaid)';

  @override
  bool operator ==(covariant Winner other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.walletAddress == walletAddress &&
        other.isPaid == isPaid;
  }

  @override
  int get hashCode => email.hashCode ^ walletAddress.hashCode ^ isPaid.hashCode;
}
