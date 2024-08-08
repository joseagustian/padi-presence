import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/shared_preferences.dart';
import 'package:padi/modules/navigation_provider.dart';

class AppScaffold extends ConsumerStatefulWidget {
  final Widget child;

  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {

  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  @override
  Widget build(BuildContext context) {
    final position = ref.watch(navigationProvider);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.blueGrey.shade100,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
          unselectedItemColor: Colors.blueGrey.shade700,
          selectedItemColor: Colors.blueGrey.shade900,
          type: BottomNavigationBarType.fixed,
          currentIndex: position,
          onTap: _onTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  Bootstrap.collection
              ),
              activeIcon: Icon(
                  Bootstrap.collection_fill
              ),
              label: Strings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Bootstrap.clipboard_check
              ),
              activeIcon: Icon(
                  Bootstrap.clipboard_check_fill
              ),
              label: Strings.attendance,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Bootstrap.pass
              ),
              activeIcon: Icon(
                  Bootstrap.pass_fill
              ),
              label: Strings.submission,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Bootstrap.gear
              ),
              activeIcon: Icon(
                  Bootstrap.gear_fill
              ),
              label: Strings.settings,
            ),
          ],
        ),
      )
    );
  }

  void _onTap(int index) {
    ref.read(navigationProvider.notifier).setPosition(index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/dashboard');
        break;
      case 1:
        GoRouter.of(context).go('/attendance-record');
        break;
      case 2:
        GoRouter.of(context).go('/submission');
        break;
      case 3:
        GoRouter.of(context).go('/settings');
        break;
    }
  }

}

