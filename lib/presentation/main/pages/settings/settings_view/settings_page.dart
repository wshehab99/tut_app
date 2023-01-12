import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:tut_app/app/app_preferences.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/data/data_source/local_data_source.dart';
import 'package:tut_app/presentation/resources/asset_manger.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manger.dart';
import 'package:tut_app/presentation/resources/value_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SizeValuesManager.s10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsWidget(
              iconPath: ImageAsset.changeLangIc,
              tittle: StringManger.changeLanguage.tr(),
              onTap: _changeLanguage,
            ),
            SettingsWidget(
              iconPath: ImageAsset.inviteFriendsIc,
              tittle: StringManger.inviteFriends.tr(),
              onTap: _inviteFriends,
            ),
            SettingsWidget(
              iconPath: ImageAsset.contactUsIc,
              tittle: StringManger.contactUs.tr(),
              onTap: _contactUs,
            ),
            SettingsWidget(
              iconPath: ImageAsset.logoutIc,
              tittle: StringManger.logout.tr(),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  void _logout() {
    // logout from app pref
    _appPreferences.setLoggedOutSuccessfully();
    // clear cached data
    _localDataSource.clearCache();
    // go back to login page
    Navigator.of(context).pushReplacementNamed(RoutesManager.loginRoute);
  }

  void _inviteFriends() async {
    await FlutterShare.share(
      title: StringManger.inviteFriendsTitle.tr(),
      text: StringManger.inviteFriendsText.tr(),
    );
  }

  void _contactUs() {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

// ·
    final Uri emailLaunchUri = Uri(
      scheme: StringManger.contactUsScheme,
      path: StringManger.contactUsPath,
      query: encodeQueryParameters(<String, String>{
        StringManger.subject: StringManger.contactUsSubject.tr(),
      }),
    );

    launchUrl(emailLaunchUri);
  }
}
