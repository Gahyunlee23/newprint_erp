part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserProfile homeData;
  HomeLoaded({required this.homeData});
}

class HomeError extends HomeState {
  final String error;
  HomeError({required this.error});
}