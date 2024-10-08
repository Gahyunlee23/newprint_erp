import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'package:newprint_erp/authentication/authentication.dart';
import 'package:newprint_erp/features/home/home.dart';
import 'package:newprint_erp/features/login/login.dart';
import 'package:newprint_erp/features/splash/splash.dart';

import 'package:newprint_erp/shared/providers/theme_provider.dart';
import 'package:newprint_erp/features/home/bloc/home_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final Dio _dio;
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: 'https://web.newprint.com/api'));
    _authenticationRepository = AuthenticationRepository(_dio);
    _userRepository = UserRepository(_dio);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          BlocProvider(
            create: (_) => HomeBloc(userRepository: _userRepository)..add(LoadHomeData()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context, listen: false).themeData,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
