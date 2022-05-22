import 'package:flutter/material.dart';
import 'package:octo_mood/pages/auth/login_page.dart';
import 'package:octo_mood/pages/auth/register_page.dart';
import 'package:octo_mood/pages/home/home_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/LoginPage':
        return MaterialPageRoute(
            builder: (_) => const LoginPage(
                ));
      case '/RegisterPage':
        return MaterialPageRoute(
            builder: (_) =>const RegisterPage(
                ));
       case '/HomePage':
        return MaterialPageRoute(
            builder: (_) =>const HomePage(
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for  ${settings.name}')),
                ));
    }
  }
}