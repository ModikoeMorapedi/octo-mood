import 'package:flutter/material.dart';
import 'package:octo_mood/pages/auth/login_page.dart';
import 'package:octo_mood/pages/auth/register_page.dart';
import 'package:octo_mood/pages/home/home_page.dart';
import 'package:octo_mood/pages/mood/mood_status.dart';
import 'package:octo_mood/pages/mood/moods_page.dart';
import 'package:octo_mood/pages/settings/settings_page.dart';
import 'package:octo_mood/utils/strings_util.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StringsUtil.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case StringsUtil.registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case StringsUtil.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case StringsUtil.moodsPage:
        return MaterialPageRoute(builder: (_) => MoodsPage(userMoodsList: []));
      case StringsUtil.moodStatusPage:
        return MaterialPageRoute(builder: (_) => const MoodStatusPage());
      case StringsUtil.settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for  ${settings.name}')),
                ));
    }
  }
}
