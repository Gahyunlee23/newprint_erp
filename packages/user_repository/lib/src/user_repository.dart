import 'dart:html';

import 'package:dio/dio.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/models/user_profile.dart';
import 'package:shared_utils/shared_utils.dart';

class UserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  Future<void> initialize() async {
    final jwtToken = await TokenManager.getToken();
    if (jwtToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $jwtToken';
    }
  }

  Future<UserProfile> getUser() async {
    try {
      final response = await _dio.get('/user');
      return UserProfile.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user');
    }
  }

  Future<UserProfile> updateUser(UpdateUserProfile user ) async {
    try {
      final response = await _dio.post(
          'v1/users',
          data: UpdateUserProfile(
              name: user.name,
              email: user.email,
              password: user.password,
              timezone: user.timezone,
              profileImageUrl: user.profileImageUrl,
              statusMsg: user.statusMsg,
              statusEmoji: user.statusEmoji
          )
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}

