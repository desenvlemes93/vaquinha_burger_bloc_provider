import 'package:flutter/material.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/colors_app.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';

sealed class AppStyles {
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: ColorsApp.primary,
        textStyle: TextStyles.textButtonLabel,
      );
}
