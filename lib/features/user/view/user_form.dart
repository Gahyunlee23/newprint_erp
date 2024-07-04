import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprint_erp/features/user/user.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key})


  @override
  Widget build(BuildContext context) {
    BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) {
      },
    );
    throw UnimplementedError();
  }}