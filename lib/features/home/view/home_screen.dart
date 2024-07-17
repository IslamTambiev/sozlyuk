import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sozlyuk/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        SearchRoute(),
        SavedRoute(),
        InfoRoute(),
      ],
      builder: (context, child, tabsRouter) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            height: 70,
            onDestinationSelected: (index) => _openPage(index, tabsRouter),
            destinations: [
              NavigationDestination(
                icon: _buildAnimatedIcon(
                  uniqueIndex: 0,
                  activeIndex: tabsRouter.activeIndex,
                  currentIndex: 0,
                  activeIcon: Icons.search,
                  inactiveIcon: Icons.search_outlined,
                ),
                // tabsRouter.activeIndex == 0
                //     ? const Icon(Icons.search)
                //     : const Icon(Icons.search_outlined),
                label: 'Поиск',
                tooltip: '',
              ),
              NavigationDestination(
                icon: _buildAnimatedIcon(
                  uniqueIndex: 1,
                  activeIndex: tabsRouter.activeIndex,
                  currentIndex: 1,
                  activeIcon: Icons.bookmark,
                  inactiveIcon: Icons.bookmark_outline,
                ),
                // tabsRouter.activeIndex == 1
                //             ? const Icon(Icons.bookmark)
                //             : const Icon(Icons.bookmark_outline),
                label: 'Избранное',
                tooltip: '',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.history),
              //   label: 'История',
              // ),
              NavigationDestination(
                icon: _buildAnimatedIcon(
                  uniqueIndex: 2,
                  activeIndex: tabsRouter.activeIndex,
                  currentIndex: 2,
                  activeIcon: Icons.settings,
                  inactiveIcon: Icons.settings_outlined,
                ),
                // tabsRouter.activeIndex == 2
                //     ? const Icon(Icons.settings)
                //     : const Icon(Icons.settings_outlined),
                label: 'Настройки',
                tooltip: '',
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

  Widget _buildAnimatedIcon({
    required int uniqueIndex,
    required int activeIndex,
    required int currentIndex,
    required IconData activeIcon,
    required IconData inactiveIcon,
  }) {
    if (activeIndex == currentIndex) {
      uniqueIndex += 1;
    }
    return AnimatedSwitcher(
      switchInCurve: Curves.ease,
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.0, 0.1),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Icon(
        key: Key(uniqueIndex.toString()),
        activeIndex == currentIndex ? activeIcon : inactiveIcon,
      ),
    );
  }
}
