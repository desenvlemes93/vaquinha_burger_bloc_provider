import 'package:flutter/material.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/app_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';

sealed class ThemeConfig {
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: Colors.green[400]!),
  );

  static final theme = ThemeData(
    useMaterial3: false ,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        )),
    primaryColor: ColorsApp.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.primary,
      primary: ColorsApp.primary,
      secondary: ColorsApp.secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.all(13),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        labelStyle: TextStyles.textRegular.copyWith(
          color: Colors.black,
        ),
        errorStyle: TextStyles.textRegular.copyWith(
          color: Colors.red,
        )),
  );
}
