part of 'user_settings_bloc.dart';

abstract class UserSettingsEvent extends Equatable {
  const UserSettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadUserSettings extends UserSettingsEvent {}

class UpdatePassword extends UserSettingsEvent {
  final String password;

  UpdatePassword(this.password);

  @override
  List<Object> get props => [password];
}

class UpdateTimezone extends UserSettingsEvent {
  final DateTime timezone;

  UpdateTimezone(this.timezone);

  @override
  List<Object> get props => [timezone];
}

class UpdateCustomStatus extends UserSettingsEvent {
  final String customStatus;

  UpdateCustomStatus(this.customStatus);

  @override
  List<Object> get props => [customStatus];
}

class UpdateEmoji extends UserSettingsEvent {
  final String emoji;

  UpdateEmoji(this.emoji);
  @override
  List<Object> get props => [emoji];
}

class UploadingProfileImageUrl extends UserSettingsEvent {
  final String profileImageUrl;

  UploadingProfileImageUrl(this.profileImageUrl);

  @override
  List<Object> get props => [profileImageUrl];
}