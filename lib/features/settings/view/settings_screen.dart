import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sozlyuk/features/settings/settings.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          title: Text(
            'Настройки',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
          ),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: 'Темная тема',
            value: false,
            onChanged: (value) {},
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const AboutTheApplication(),
          ),
        ),
      ],
    );
  }
}
