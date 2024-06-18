import 'package:equatable/equatable.dart';

class SubMenu extends Equatable {
  final String name;
  final List<String> permissions;

  SubMenu({
    required this.name,
    required this.permissions,
  });

  factory SubMenu.fromJson(Map<String, dynamic> json) {
    return SubMenu(
      name: json['name'] as String,
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }

  @override
  List<Object?> get props => [name, permissions];
}