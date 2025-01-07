import 'mission.dart';

class UserMission {
  final String missionId;
  bool isCompleted;
  final Mission mission;

  UserMission({
    required this.missionId,
    this.isCompleted = false,
    required this.mission,
  });

  factory UserMission.fromJson(Map<String, dynamic> json) {
    return UserMission(
      missionId: json['mission_id'].toString(),
      isCompleted: json['is_completed']== 1,
      mission: Mission.fromJson(json['mission']),
    );
  }
}
