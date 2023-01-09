import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(StringManger.search),
    );
  }
}
