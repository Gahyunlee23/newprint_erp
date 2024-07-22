import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../bloc/user_settings_bloc.dart';

class UserSettingsForm extends StatefulWidget {
  final UserProfile userProfile;

  const UserSettingsForm({Key? key, required this.userProfile}) : super(key: key);

  @override
  _UserSettingsFormState createState() => _UserSettingsFormState();
}

class _UserSettingsFormState extends State<UserSettingsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _timezoneController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _timezoneController = TextEditingController(text: widget.userProfile.timezone.toIso8601String());
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _timezoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSettingsBloc, UserSettingsState>(
      listener: (context, state) {
        if (state is UserSettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _timezoneController,
                decoration: InputDecoration(labelText: 'Timezone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter timezone';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Handle timezone changes
                },
              ),
              SizedBox(height: 16.0),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                onChanged: (value) {
                  // Handle password changes
                },
              ),
              SizedBox(height: 16.0),

              // Custom Status Message Input Field (Example)
              TextFormField(
                decoration: InputDecoration(labelText: 'Custom Status'),
                onChanged: (value) {
                  // Handle custom status changes
                },
              ),
              SizedBox(height: 16.0),

              // System Emoji Selection (Example)
              ListTile(
                title: Text('Select System Emoji'),
                trailing: DropdownButton<String>(
                  value: '😊', // Replace with actual selected emoji value
                  onChanged: (String? newValue) {
                    // Handle emoji selection
                  },
                  items: <String>['😊', '😁', '😎'] // Replace with actual emoji options
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  // 사용자가 입력한 값을 처리하는 로직을 추가합니다.
                  String timezoneString = _timezoneController.text;
                  DateTime? timezone;
                  try {
                    timezone = DateTime.parse(timezoneString);
                  } catch (e) {
                    // 변환 실패 시 처리
                    print('Invalid DateTime format');
                  }

                  if (timezone != null) {
                    // 사용자가 입력한 password와 함께 업데이트 로직을 추가합니다.
                    print('Timezone: $timezone');
                    print('Password: ${_passwordController.text}');
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
