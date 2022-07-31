// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Competition {
  int count;
  int startDateTime;
  String name;
  String winnerWallet;
  Competition({
    required this.count,
    required this.startDateTime,
    required this.name,
    required this.winnerWallet,
  });

  Competition copyWith({
    int? count,
    int? startDateTime,
    String? name,
    String? winnerWallet,
  }) {
    return Competition(
      count: count ?? this.count,
      startDateTime: startDateTime ?? this.startDateTime,
      name: name ?? this.name,
      winnerWallet: winnerWallet ?? this.winnerWallet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'startDateTime': startDateTime,
      'name': name,
      'winnerWallet': winnerWallet,
    };
  }

  factory Competition.fromMap(Map<String, dynamic> map) {
    return Competition(
      count: map['count'] as int,
      startDateTime: map['startDateTime'] as int,
      name: map['name'] as String,
      winnerWallet: map['winnerWallet'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Competition.fromJson(String source) =>
      Competition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Competition(count: $count, startDateTime: $startDateTime, name: $name, winnerWallet: $winnerWallet)';
  }

  @override
  bool operator ==(covariant Competition other) {
    if (identical(this, other)) return true;

    return other.count == count &&
        other.startDateTime == startDateTime &&
        other.name == name &&
        other.winnerWallet == winnerWallet;
  }

  @override
  int get hashCode {
    return count.hashCode ^
        startDateTime.hashCode ^
        name.hashCode ^
        winnerWallet.hashCode;
  }
}
