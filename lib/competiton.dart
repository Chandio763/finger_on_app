// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Competition {
  String winner;
  int count;
  Competition({
    required this.winner,
    required this.count,
  });

  Competition copyWith({
    String? winner,
    int? count,
  }) {
    return Competition(
      winner: winner ?? this.winner,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'winner': winner,
      'count': count,
    };
  }

  factory Competition.fromMap(Map<String, dynamic> map) {
    return Competition(
      winner: map['winner'] as String,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Competition.fromJson(String source) =>
      Competition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Competition(winner: $winner, count: $count)';

  @override
  bool operator ==(covariant Competition other) {
    if (identical(this, other)) return true;

    return other.winner == winner && other.count == count;
  }

  @override
  int get hashCode => winner.hashCode ^ count.hashCode;
}
