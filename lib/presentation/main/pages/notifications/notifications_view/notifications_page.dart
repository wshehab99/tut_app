import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(StringManger.notifications),
    );
  }
}
