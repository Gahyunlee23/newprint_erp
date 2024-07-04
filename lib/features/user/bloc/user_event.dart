part of 'user_bloc.dart';

abstract class UserEvent {}

class LoadUserData extends UserEvent {
  LoadUserData();
}
