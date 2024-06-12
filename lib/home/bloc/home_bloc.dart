import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final UserRepository _userRepository;

  HomeBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(HomeInitial());

  Stream<HomeState> mapEventToState(
      HomeEvent event,
      ) async* {
    if (event is LoadHomeData) {
      yield* _mapLoadHomeDataToState(event);
    }
  }

  Stream<HomeState> _mapLoadHomeDataToState(LoadHomeData event) async* {
    yield HomeLoading();
    try {
      final user = await _userRepository.getUser();
      final homeData = UserProfile(
        email: user.email,
        name: user.name,
        timezone: user.timezone,
        groupRoleName: user.groupRoleName,
        roles: user.roles,
        menus: user.menus,
      );
      yield HomeLoaded(homeData: homeData);
    } catch(error) {
      yield HomeError(error: error.toString());
    }
  }
}
