import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sozlyuk/features/favorites/favorites.dart';
import 'package:sozlyuk/features/home/home.dart';
import 'package:sozlyuk/features/search/search.dart';
import 'package:sozlyuk/features/settings/settings.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: SearchRoute.page,
              path: 'search',
            ),
            AutoRoute(
              page: SavedRoute.page,
              path: 'favorites',
            ),
            AutoRoute(
              page: InfoRoute.page,
              path: 'settings',
            ),
          ],
        ),
        // AutoRoute(page: CryptoListRoute.page, path: '/'),
        // AutoRoute(page: CryptoCoinRoute.page, path: '/coin'),
      ];
}
