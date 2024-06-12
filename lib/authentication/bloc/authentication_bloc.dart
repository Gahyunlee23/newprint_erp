import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
  _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
      _AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit,
      ) async {
    print('Authentication status changed: ${event.status}');
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        print('User is unauthenticated');
        emit(const AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        print('User is authenticated');
        final user = await _tryGetUser();
        emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
        break;
      case AuthenticationStatus.unknown:
        print('Authentication status is unknown');
        emit(const AuthenticationState.unknown());
        break;
    }
  }

  void _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit,
      ) {
    print('Logout requested');
    _authenticationRepository.logOut();
  }

  Future<UserProfile?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      print('Failed to fetch user information');
      return null;
    }
  }
}