import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/src/models/user_profile.dart';

class UserRepository {
  Future<UserProfile> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      if(token == null) {
        throw Exception('jwt token is null');
      }

      var userProfileUrl = Uri.https('web.newprint.com', '/v1/users/profile');

      var response = await http.get(
          userProfileUrl,
          headers: {'Authorization': 'Bearer $token'}
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        return UserProfile.fromJson(userData);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<void> updateUser(UserProfile user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');
      if (token == null) {
        throw Exception('JWT token is null');
      }

      var updateUserProfileUrl = Uri.https('web.newprint.com', '/v1/users/profile');

      var response = await http.put(
        updateUserProfileUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}

