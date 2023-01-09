import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(StringManger.home),
    );
  }
}
