part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserProfile homeData;
  UserLoaded({required this.homeData});
}

class UserError extends UserState {
  final String error;
  UserError({required this.error});
}

