import 'package:eco/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

/// Navigation entry point for app.
class Root extends StatelessWidget {
  static const route = '/';

  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        // Create bottom navigation bar items from screens.
        final bottomNavigationBarItems = provider.screens
            .asMap()
            .entries
            .map(
              (entries) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: SvgPicture.asset(
                    entries.value.icon,
                    color: provider.currentTabIndex == entries.key
                        ? const Color(0xFF7FA8D3)
                        : const Color(0xFF9A9A9A),
                  ),
                ),
                label: entries.value.title,
              ),
            )
            .toList();

        // Initialize [Navigator] instance for each screen.
        final screens = provider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return WillPopScope(
          onWillPop: () async => provider.onWillPop(context),
          child: Scaffold(
            body: IndexedStack(
              children: screens,
              index: provider.currentTabIndex,
            ),
            bottomNavigationBar: Container(
              height: 70,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(99, 99, 99, 0.02),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                items: bottomNavigationBarItems,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                unselectedItemColor: const Color(0xFF9A9A9A),
                selectedItemColor: const Color(0xFF7FA8D3),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.currentTabIndex,
                onTap: provider.setTab,
              ),
            ),
          ),
        );
      },
    );
  }
}
