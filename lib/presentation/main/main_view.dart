import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'pages/home_page.dart';
import 'pages/notifications_page.dart';
import 'pages/search_page.dart';
import 'pages/settings_page.dart';

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
  final List<String> _titles = const [
    StringManger.home,
    StringManger.search,
    StringManger.notifications,
    StringManger.settings,
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: StringManger.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: StringManger.search,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: StringManger.notifications,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: StringManger.settings,
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
