import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_settings_event.dart';
part 'user_settings_state.dart';

class UserSettingsBloc extends Bloc<UserSettingsEvent, UserSettingsState> {
  final UserRepository userRepository;
  static const String errorMessage = 'Failed to update user settings';

  UserSettingsBloc(this.userRepository) : super(UserSettingsInitial());

  @override
  Stream<UserSettingsState> _mapLoadUserSettingsToState() async* {
    yield UserSettingsLoading();
    try {
      final user = await userRepository.getUser();
      yield UserSettingsLoaded(user);
    } catch (e) {
      yield UserSettingsError('Failed to load user settings');
    }
  }

  Stream<UserSettingsState> _mapUpdateUserSettingToState(UserProfile Function(UserProfile) update) async* {
    if (state is UserSettingsLoaded) {
      final updatedUser = update((state as UserSettingsLoaded).user);
      yield UserSettingsLoading();
      try {
        final updateUserProfile = UpdateUserProfile.fromUserProfile(updatedUser);
        final newUserProfile = await userRepository.updateUser(updateUserProfile);
        yield UserSettingsLoaded(newUserProfile);
      } catch (e) {
        yield UserSettingsError(errorMessage);
      }
    }
  }
}
