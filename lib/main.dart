import 'package:flutter/material.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/config/env/env.dart';
import 'package:vaquinha_burger_provider_bloc/app/dw9_delivery_app.dart';

void main() async {
  await Env.load();
  runApp( Dw9DeliveryApp());
}
