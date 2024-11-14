import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String messages) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: messages,
        ));
  }

  void showInfo(String messages) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          message: messages,
        ));
  }

  void showSucess(String messages) {
    showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: messages,
        ));
  }
}
