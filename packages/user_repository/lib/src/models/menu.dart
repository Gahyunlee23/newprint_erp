import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String name;
  final List<SubMenu> subMenus;

  Menu({
    required this.name,
    required this.subMenus,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    final List<dynamic> subMenusData = json['subMenus'] ?? [];
    final List<SubMenu> subMenus =
    subMenusData.map((data) => SubMenu.fromJson(data)).toList();

    return Menu(
      name: json['name'] as String,
      subMenus: subMenus,
    );
  }

  @override
  List<Object?> get props => [name, subMenus];
}

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
