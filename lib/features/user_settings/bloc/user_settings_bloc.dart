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
  Stream<UserSettingsState> mapEventToState(UserSettingsEvent event) async* {
    if (event is LoadUserSettings) {
      yield* _mapLoadUserSettingsToState();
    } else if (event is UpdatePassword) {
      yield* _mapUpdateUserSettingToState((user) => user.copyWith(password: event.password));
    } else if (event is UpdateTimezone) {
      yield* _mapUpdateUserSettingToState((user) => user.copyWith(timezone: event.timezone));
    } else if (event is UpdateCustomStatus) {
      yield* _mapUpdateUserSettingToState((user) => user.copyWith(customStatus: event.customStatus));
    } else if (event is UpdateEmoji) {
      yield* _mapUpdateUserSettingToState((user) => user.copyWith(emoji: event.emoji));
    }
  }

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
        await userRepository.updateUser(updatedUser);
        yield UserSettingsLoaded(updatedUser);
      } catch (e) {
        yield UserSettingsError(errorMessage);
      }
    }
  }
}
