import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/helpers/loader.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/helpers/messages.dart';


abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Messages {
  late final C controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = context.read();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onRead();
    });
  }

  void onRead() {}
}
