import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/navigation/navigation_cubit.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const _AppShellView(),
    );
  }
}

class _AppShellView extends StatelessWidget {
  const _AppShellView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        final pages = [
          HomeScreen(onNavigate: context.read<NavigationCubit>().selectTab),
          HistoryScreen(key: ValueKey(state.historyVersion)),
          const ProfileScreen(),
        ];
        return Scaffold(
          body: IndexedStack(index: state.index, children: pages),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.index,
            onDestinationSelected: context.read<NavigationCubit>().selectTab,
            backgroundColor: Colors.white,
            indicatorColor: const Color(0xFFDDF0D9),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
              NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
              NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        );
      },
    );
  }
}
