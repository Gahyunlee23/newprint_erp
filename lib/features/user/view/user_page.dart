import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprint_erp/features/user/user.dart';
import 'package:user_repository/user_repository.dart';

import '../../home/bloc/home_bloc.dart';
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UserPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context))..add(LoadHomeData() as UserEvent),
    );
  }
}