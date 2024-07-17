import 'package:dio/dio.dart';
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
}

