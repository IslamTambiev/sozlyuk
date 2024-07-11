import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sozlyuk/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
      routes: const [
        SearchRoute(),
        SavedRoute(),
        InfoRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) => _openPage(index, tabsRouter),
            destinations: [
              NavigationDestination(
                icon: tabsRouter.activeIndex == 0
                  ? const Icon(Icons.search)
                  : const Icon(Icons.search_outlined),
                label: 'Поиск',
              ),
              NavigationDestination(
                icon: tabsRouter.activeIndex == 1
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_outline),
                label: 'Избранное',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.history),
              //   label: 'История',
              // ),
              NavigationDestination(
                icon: tabsRouter.activeIndex == 2
                    ? const Icon(Icons.settings)
                    : const Icon(Icons.settings_outlined),
                label: 'Настройки',
              ),
            ],
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}