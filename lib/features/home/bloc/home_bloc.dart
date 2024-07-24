import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;

  HomeBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  void _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final user = await _userRepository.getUser();
      final homeData = UserProfile(
        email: user.email,
        name: user.name,
        password: user.password,
        timezone: user.timezone,
        groupRoleName: user.groupRoleName,
        roles: user.roles,
        menus: user.menus,
      );
      emit(HomeLoaded(homeData: homeData));
    } catch (error) {
      emit(HomeError(error: error.toString()));
    }
  }
  //
}
