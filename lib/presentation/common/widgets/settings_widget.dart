import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/presentation/resources/language_manager.dart';

import '../../resources/asset_manger.dart';
import 'dart:math' as math;

class SettingsWidget extends StatefulWidget {
  const SettingsWidget(
      {super.key, required this.tittle, required this.iconPath, this.onTap});
  final String iconPath;
  final String tittle;
  final void Function()? onTap;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(widget.iconPath),
      title: Text(
        widget.tittle,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      trailing: Transform(
          transform: Matrix4.rotationY(_isAr() ? math.pi : 0),
          child: SvgPicture.asset(ImageAsset.rightArrowSettingsIc)),
      onTap: widget.onTap,
    );
  }

  bool _isAr() {
    return context.locale == LanguageType.arabic.getLocale();
  }
}
