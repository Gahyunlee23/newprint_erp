import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../bloc/user_settings_bloc.dart';
import 'user_settings_form.dart';

class UserSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSettingsBloc(UserRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text('User Settings')),
        body: BlocBuilder<UserSettingsBloc, UserSettingsState>(
          builder: (context, state) {
            if (state is UserSettingsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserSettingsLoaded) {
              final userProfile = state.user;

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text(userProfile.name),
                      dense: true,
                    ),
                    ListTile(
                      title: Text('Email'),
                      subtitle: Text(userProfile.email),
                      dense: true,
                    ),

                    Divider(),

                    // Display the UserSettingsForm widget
                    UserSettingsForm(userProfile: userProfile),
                  ],
                ),
              );
            } else if (state is UserSettingsError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Failed to load user settings.'));
            }
          },
        ),
      ),
    );
  }
}
