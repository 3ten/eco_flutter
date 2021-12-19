import 'package:eco/models/screen.dart';
import 'package:eco/screens/check_list/check_list_screen.dart';
import 'package:eco/screens/info/info_screen.dart';
import 'package:eco/screens/project/project_info_screen.dart';
import 'package:eco/screens/project/project_screen.dart';
import 'package:eco/screens/report/report_info_screen.dart';
import 'package:eco/screens/report/report_screen.dart';
import 'package:eco/screens/root.dart';
import 'package:eco/screens/setting/setting_screen.dart';
import 'package:eco/widgets/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const FIRST_SCREEN = 0;
const SECOND_SCREEN = 1;
const THIRD_SCREEN = 2;
const FOURTH_SCREEN = 3;
const FIFTH_SCREEN = 4;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      context.watch<NavigationProvider>();

  int _currentScreenIndex = FIRST_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      case CheckListScreen.route:
        return MaterialPageRoute(builder: (_) => const CheckListScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Root());
    }
  }

  final Screen _notFoundScreen = Screen(
    title: 'First',
    icon: 'assets/icons/tab/home.svg',
    child: const CheckListScreen(),
    initialRoute: CheckListScreen.route,
    navigatorState: GlobalKey<NavigatorState>(),
    onGenerateRoute: (settings) {
      print('Generating route: ${settings.name}');
      switch (settings.name) {
        case CheckListScreen.route:
          return MaterialPageRoute(builder: (_) => const CheckListScreen());
        default:
          return MaterialPageRoute(builder: (_) => const Root());
      }
    },
    scrollController: ScrollController(),
  );

  final Map<int, Screen> _screens = {
    FIRST_SCREEN: Screen(
      title: 'Чек-лист',
      icon: 'assets/icons/tab/checklist.svg',
      child: const CheckListScreen(),
      initialRoute: CheckListScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => const CheckListScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    SECOND_SCREEN: Screen(
      title: 'Проекты',
      icon: 'assets/icons/tab/project.svg',
      child: const ProjectScreen(),
      initialRoute: ProjectScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case ProjectInfoScreen.route:
            return MaterialPageRoute(builder: (_) => const ProjectInfoScreen());
          default:
            return MaterialPageRoute(builder: (_) => const ProjectScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    THIRD_SCREEN: Screen(
      title: 'Отчеты',
      icon: 'assets/icons/tab/application.svg',
      child: const ReportScreen(),
      initialRoute: ReportScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case ReportInfoScreen.route:
            return MaterialPageRoute(builder: (_) => const ReportInfoScreen());
          default:
            return MaterialPageRoute(builder: (_) => const ReportScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    FOURTH_SCREEN: Screen(
      title: 'Инфо',
      icon: 'assets/icons/tab/message.svg',
      child: const InfoScreen(),
      initialRoute: InfoScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => const InfoScreen());
        }
      },
      scrollController: ScrollController(),
    ),
    FIFTH_SCREEN: Screen(
      title: 'Настройки',
      icon: 'assets/icons/tab/profile.svg',
      child: const SettingScreen(),
      initialRoute: SettingScreen.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => const SettingScreen());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex] ?? _notFoundScreen;

  /// Set currently visible tab.
  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen.scrollController != null &&
        currentScreen.scrollController!.hasClients) {
      currentScreen.scrollController!.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState!.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != FIRST_SCREEN) {
        setTab(FIRST_SCREEN);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}
