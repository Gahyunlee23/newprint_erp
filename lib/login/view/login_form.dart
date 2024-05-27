import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprint_erp/login/bloc/login_bloc.dart';
import 'package:newprint_erp/login/login.dart';
import 'package:formz/formz.dart';
import 'package:newprint_erp/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<_RememberMeCheckboxState>(
      create: (_) => _RememberMeCheckboxState(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 336,
                  height: 46,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5, right: 9, bottom: 3),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 147,
                              height: 38,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("https://www.newprint.ca/media/logo/default/logo.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(12)),
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RememberMeCheckbox(),
                    _ForgotPasswordButton(),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatefulWidget {
  final String labelText;
  final ValueChanged<String> onChanged;
  final dynamic error;
  final bool isPassword;

  const _InputField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.error,
    this.isPassword = false,
  }) : super(key: key);

  @override
  __InputFieldState createState() => __InputFieldState();
}

class __InputFieldState extends State<_InputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _getErrorText(dynamic error) {
    if (error is UsernameValidationError) {
      return 'Invalid username';
    } else if (error is PasswordValidationError) {
      return 'Invalid password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final hasError = widget.error != null;
        return TextField(
          onChanged: widget.onChanged,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryColor),
            ),
            labelText: widget.labelText,
            labelStyle: TextStyle(
                color: hasError ? AppTheme.errorColor : (_isFocused ? AppTheme.primaryColor : null)),
            errorText: _getErrorText(widget.error),
            suffixIcon: widget.isPassword
                ? TextButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Text(
                _obscureText ? 'Show' : 'Hide',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                ),
              ),
            ) : null,
          ),
          focusNode: _focusNode,
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InputField(
      key: const Key('loginForm_usernameInput_textField'),
      labelText: 'Email',
      onChanged: (username) =>
          context.read<LoginBloc>().add(LoginUsernameChanged(username)),
      error: context.select((LoginBloc bloc) => bloc.state.username.displayError),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InputField(
      key: const Key('loginForm_passwordInput_textField'),
      labelText: 'Password',
      onChanged: (password) =>
          context.read<LoginBloc>().add(LoginPasswordChanged(password)),
      error: context.select((LoginBloc bloc) => bloc.state.password.displayError),
      isPassword: true,
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Forgot Password'),
              content: Text('Password reset functionality is not implemented yet.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        'Forgot your password?',
        style: TextStyle(color: AppTheme.primaryColor),
      ),
    );
  }
}

class _RememberMeCheckbox extends StatefulWidget {
  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<_RememberMeCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text('Remember Me'),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: AppTheme.primaryColor,
      fixedSize: Size(336, 42),
    );
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          style: style,
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.isValid
              ? () {
            final username = context.read<LoginBloc>().state.username.value;
            final password = context.read<LoginBloc>().state.password.value;
            final rememberMe = context.read<_RememberMeCheckboxState>().isChecked;
            if (rememberMe) {
              _saveCredentials(username, password);
            }
            context.read<LoginBloc>().add(const LoginSubmitted());
          }
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
}
