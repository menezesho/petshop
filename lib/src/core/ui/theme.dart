import 'package:petshop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

sealed class PetShopTheme {
  static const _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: ColorsConstants.grey));

  static ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      primary: ColorsConstants.grey,
    ),
    textTheme: const TextTheme(
      labelMedium: TextStyle(
        color: ColorsConstants.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(10),
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(
        color: ColorsConstants.grey,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      hintStyle: const TextStyle(
        color: ColorsConstants.grey,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      errorStyle: const TextStyle(
        color: ColorsConstants.red,
        fontSize: 14,
        fontWeight: FontWeight.w300,
      ),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: ColorsConstants.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConstants.strongGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    fontFamily: FontConstants.fontFamily,
  );
}
