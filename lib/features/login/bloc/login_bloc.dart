import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newprint_erp/features/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) {
    _onCredentialChanged(
      Username.dirty(event.username),
      state.password,
      emit,
    );
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    _onCredentialChanged(
      state.username,
      Password.dirty(event.password),
      emit,
    );
  }

  void _onCredentialChanged(
      Username username,
      Password password,
      Emitter<LoginState> emit,
      ) {
    emit(
      state.copyWith(
        username: username,
        password: password,
        isValid: Formz.validate([username, password]),
      ),
    );
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (error) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, error: error.toString()));
      }
    }
  }
}
