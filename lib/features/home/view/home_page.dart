import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newprint_erp/features/home/bloc/home_bloc.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(userRepository: RepositoryProvider.of<UserRepository>(context))..add(LoadHomeData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Cards'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              final user = state.homeData;
              final now = DateTime.now();
              final currentHour = now.hour;
              final greeting = _getGreetingMessage(currentHour);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Hello, ${user.name}\n$greeting',
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Container(
                  //   width: 173,
                  //   height: 46,
                  //   child: user.profileImageUrl != null
                  //       ? Image(image: NetworkImage(user.profileImageUrl))
                  //       : Icon(Icons.person)
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: user.menus.length,
                      itemBuilder: (context, index) {
                        final menu = user.menus[index];
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  menu.name,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: menu.subMenus.length,
                                  itemBuilder: (context, subIndex) {
                                    final subMenu = menu.subMenus[subIndex];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SubMenuPage(subMenu: subMenu),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          subMenu.name,
                                          style: const TextStyle(fontSize: 16.0, color: Colors.blue),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  String _getGreetingMessage(int hour) {
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

class SubMenuPage extends StatelessWidget {
  final SubMenu subMenu;

  const SubMenuPage({Key? key, required this.subMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subMenu.name),
      ),
      body: ListView.builder(
        itemCount: subMenu.permissions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subMenu.permissions[index]),
          );
        },
      ),
    );
  }
}
