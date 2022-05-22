import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:octo_mood/pages/splash/splash_page.dart';
import 'package:octo_mood/utils/helper/sizeConfig.dart';
import 'package:octo_mood/utils/routes_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          title: 'Octo Mood App',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: const SplashPage(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
        );
      });
    });
  }
}
