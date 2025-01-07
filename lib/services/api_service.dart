import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/mission.dart';
import 'dart:io';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Fetch user data
  Future<User> getUserData(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<List<Mission>> getMissions() async {
    final response = await http.get(Uri.parse('$baseUrl/missions'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Mission.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load missions');
    }
  }

  Future<void> updateMissionStatus(int userMissionId, bool isCompleted) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/user-missions/$userMissionId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'is_completed': isCompleted}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update mission status');
    }
  }
  Future<void> submitMissionProof({
    required int userId,
    required int missionId,
    required File videoFile,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/submissions'),
    );

    request.fields['user_id'] = userId.toString();
    request.fields['mission_id'] = missionId.toString();
    request.files.add(await http.MultipartFile.fromPath('proof', videoFile.path));

    var response = await request.send();

    if (response.statusCode == 201) {
      print('Submission successful!');
    } else {
      print('Submission failed: ${response.statusCode}');
    }
  }
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'message': 'Failed to register'};
    }
  }

  // Fungsi Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {'message': 'Invalid credentials'};
    }
  }
}

