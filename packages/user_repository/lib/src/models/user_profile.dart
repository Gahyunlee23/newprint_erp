import 'package:equatable/equatable.dart';
import 'package:user_repository/src/models/models.dart';
import 'menu.dart';

class UserProfile extends Equatable {
  final String email;
  final String name;
  final String password;
  final DateTime timezone;
  final String? profileImageUrl;
  final String groupRoleName;
  final String? statusMsg;
  final String? statusEmoji;
  final List<String> roles;
  final List<Menu> menus;

  UserProfile({
    required this.email,
    required this.name,
    required this.password,
    required this.timezone,
    this.profileImageUrl,
    required this.groupRoleName,
    this.statusMsg,
    this.statusEmoji,
    required this.roles,
    required this.menus
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? menusData = json['menus'];

    if (menusData == null) {
      throw FormatException("Invalid 'menus' data");
    }

    final List<Menu> menus = (json['menus'] as List<dynamic>?)
        ?.map((data) => Menu.fromJson(data as Map<String, dynamic>)).toList() ?? [];

    return UserProfile(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      timezone: json['timezone'] as DateTime,
      profileImageUrl: json['profileImageUrl'] as String,
      groupRoleName: json['groupRoleName'] as String,
      statusMsg: json['statusMsg'] as String,
      statusEmoji: json['statusEmoji'] as String,
      roles: List<String>.from(json['roles'] as List<dynamic>),
      menus: menus
    );
  }

  UserProfile copyWith({
    String? email,
    String? name,
    String? password,
    DateTime? timezone,
    String? profileImageUrl,
    String? groupRoleName,
    String? statusMsg,
    String? statusEmoji,
    List<String>? roles,
    List<Menu>? menus,
  }) {
    return UserProfile(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        timezone: timezone ?? this.timezone,
        groupRoleName: groupRoleName ?? this.groupRoleName,
        statusMsg: statusMsg ?? this.statusMsg,
        statusEmoji: statusEmoji ?? this.statusEmoji,
        roles: roles ?? this.roles,
        menus: menus ?? this.menus
    );
  }

  @override
  List<Object?> get props => [email, name, timezone, profileImageUrl, groupRoleName, statusMsg, statusEmoji, roles, menus];
}
