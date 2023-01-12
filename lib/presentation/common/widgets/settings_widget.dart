import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/asset_manger.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget(
      {super.key, required this.tittle, required this.iconPath, this.onTap});
  final String iconPath;
  final String tittle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(iconPath),
      title: Text(
        tittle,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      trailing: SvgPicture.asset(ImageAsset.rightArrowSettingsIc),
      onTap: onTap,
    );
  }
}