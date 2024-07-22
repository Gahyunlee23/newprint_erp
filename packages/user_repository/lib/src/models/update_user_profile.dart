import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/models.dart';
import 'user_profile.dart';

class UpdateUserProfile extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final DateTime timezone;
  final String? profileImageUrl;
  final String? statusMsg;
  final String? statusEmoji;

  UpdateUserProfile({
    this.name,
    this.email,
    this.password,
    required this.timezone,
    this.profileImageUrl,
    this.statusMsg,
    this.statusEmoji
  });

  factory UpdateUserProfile.fromUserProfile(UserProfile userProfile) {
    return UpdateUserProfile(
      name: userProfile.name,
      email: userProfile.email,
      password: userProfile.password,
      timezone: userProfile.timezone,
      profileImageUrl: userProfile.profileImageUrl,
      statusMsg: null,
      statusEmoji: null,
    );
  }

  @override
  List<Object?> get props => [name, email, password, timezone, profileImageUrl, statusMsg, statusEmoji];

}