import 'package:equatable/equatable.dart';

import 'menu.dart';

class UserProfile extends Equatable {
  final String email;
  final String name;
  final String timezone;
  final String? profileImageUrl;
  final String groupRoleName;
  final List<String> roles;
  final List<Menu> menus;

  UserProfile({
    required this.email,
    required this.name,
    required this.timezone,
    this.profileImageUrl,
    required this.groupRoleName,
    required this.roles,
    required this.menus,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final menusData = json['menus'] as List<dynamic>;
    final menus = menusData.map((data) => Menu.fromJson(data)).toList();

    return UserProfile(
      email: json['email'] as String,
      name: json['name'] as String,
      timezone: json['timezone'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      groupRoleName: json['groupRoleName'] as String,
      roles: List<String>.from(json['roles'] as List<dynamic>),
      menus: menus,
    );
  }

  @override
  List<Object?> get props => [email, name, timezone, profileImageUrl, groupRoleName, roles, menus];
}

