import 'package:user_repository/user_repository.dart';

import 'package:bloc/bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<LoadUserData>(_onLoadUserData);
  }

  void _onLoadUserData(LoadUserData event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await _userRepository.getUser();
      final userData = UserProfile(
        email: user.email,
        name: user.name,
        timezone: user.timezone,
        groupRoleName: user.groupRoleName,
        roles: user.roles,
        menus: user.menus,
      );
      emit(UserLoaded(homeData: userData));
    } catch (error) {
      emit(UserError(error: error.toString()));
    }
  }
}
