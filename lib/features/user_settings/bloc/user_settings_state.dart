part of 'user_settings_bloc.dart';

abstract class UserSettingsState {}

class UserSettingsInitial extends UserSettingsState {}

class UserSettingsLoading extends UserSettingsState {}

class UserSettingsLoaded extends UserSettingsState {
  final UserProfile user;
  UserSettingsLoaded(this.user);
}

class UserSettingsError extends UserSettingsState {
  final String message;

  UserSettingsError(this.message);
}

class ProfileImageUploaded extends UserSettingsState {
  final String imageUrl;

  ProfileImageUploaded(this.imageUrl);
}