import 'package:flutter/material.dart';
import 'package:petshop/src/pages/load/splash_page.dart';
import 'package:petshop/src/pages/login_page.dart';
import 'package:petshop/src/core/ui/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petshop',
      theme: PetShopTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/pages/login_page': (context) => LoginPage(),
      },
    );
  }
}
