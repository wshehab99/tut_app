import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'pages/home/home_view/home_page.dart';
import 'pages/notifications/notifications_view/notifications_page.dart';
import 'pages/search/search_view/search_page.dart';
import 'pages/settings/settings_view/settings_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];
  final List<String> _titles = [
    StringManger.home.tr(),
    StringManger.search.tr(),
    StringManger.notifications.tr(),
    StringManger.settings.tr(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_titles[_currentIndex],
              style: Theme.of(context).textTheme.titleSmall)),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home_outlined,
            ),
            label: StringManger.home.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.search,
            ),
            label: StringManger.search.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.notifications,
            ),
            label: StringManger.notifications.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            ),
            label: StringManger.settings.tr(),
          ),
        ],
        onTap: _onTap,
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
