import 'user_mission.dart';

class User {
  final int id;
  final String username;
  final String email;
  int points;
  final List<UserMission> missions;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.points = 0,
    required this.missions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      points: json['points'],
      missions: (json['user_missions'] as List)
          .map((mission) => UserMission.fromJson(mission))
          .toList(),
    );
  }
}
