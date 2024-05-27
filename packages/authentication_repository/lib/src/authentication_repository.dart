import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

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
      var url = Uri.https('web.newprint.com', 'login/jwt');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        print('Failed to login. Status code: ${response.statusCode}, Body: ${response.body}');
        _controller.add(AuthenticationStatus.unauthenticated);
      }
    } catch (error) {
      print('An error occurred: $error');
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}