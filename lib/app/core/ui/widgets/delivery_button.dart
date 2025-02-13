import 'package:flutter/material.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final double? width;
  final double? height;
  const DeliveryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 50,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyles.textButtonLabel,
          )),
    );
  }
}
