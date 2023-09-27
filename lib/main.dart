import 'package:flutter/material.dart';
import 'package:petshop/src/pages/edit_pet_page.dart';
import 'package:petshop/src/pages/login_page.dart';
import 'package:petshop/src/ui/theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: PetShopTheme.themeData,
      home: EditPetPage(idPet: 2),
    );
  }
}
