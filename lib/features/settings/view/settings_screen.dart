import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/bloc/theme/theme_cubit.dart';
import 'package:sozlyuk/features/settings/settings.dart';
import 'package:sozlyuk/ui/ui.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDark;
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
            value: isDark,
            onChanged: (value) {
              context.read<ThemeCubit>().setThemeBrightness(
                  value ? Brightness.dark : Brightness.light);
            },
          ),
        ),
        // SliverToBoxAdapter(
        //   child: SettingsMenuCard(
        //     title: 'Темная тема',
        //     value: false,
        //     onChanged: (value) {},
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
            child: BaseContainer(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: TextButton(
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))),
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationIcon:
                        Image.asset('assets/images/icon.png', height: 80),
                    applicationName: 'Сёзлюк',
                    applicationVersion: '1.0.1',
                    children: [
                      const Text(
                          'Карачаево-балкаро - русский и русско - карачаево-балкарский словарь.'),
                    ],
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(width: 10),
                        Text('О приложении',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
