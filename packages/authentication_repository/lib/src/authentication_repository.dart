import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_utils/shared_utils.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final Dio _dio;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository(this._dio);

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      var response = await _dio.post(
        '/login/jwt',
        data: {'username': username, 'password': password},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        final responseBody = response.data;
        final token = responseBody['token'];
        await TokenManager.saveToken(token);
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        print('Failed to login. Status code: ${response.statusCode}, Body: ${response.data}');
        _controller.add(AuthenticationStatus.unauthenticated);
        throw Exception('Login failed with status code: ${response.statusCode}, Body ${response.data}');
      }
    } catch (error) {
      print('An error occurred: $error');
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception('Login failed with status code: $error');

    }
  }

  Future<void> logOut() async {
    await TokenManager.clearToken();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
