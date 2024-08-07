import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sozlyuk/bloc/theme/theme_cubit.dart';
import 'package:sozlyuk/features/history/bloc/history_words_cubit.dart';
import 'package:sozlyuk/features/settings/settings.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDark;
    final doNeedToSaveHistory =
        context.watch<HistoryWordsCubit>().state.needToSaveHistory;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
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
          child: SettingsToggleCard(
            title: 'Сохранять историю',
            value: doNeedToSaveHistory,
            onChanged: (value) {
              context.read<HistoryWordsCubit>().setNeedToSaveHistory(value);
            },
          ),
        ),
        const SliverToBoxAdapter(
          child: AboutAppInfo(),
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
