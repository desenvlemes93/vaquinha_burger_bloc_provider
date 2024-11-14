import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/base_state/base_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_button.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/login/controller/login_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/login/controller/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          success: () {
            hideLoader();
            Navigator.pop(context, true);
          },
          loginError: () {
            hideLoader();
            showError('Senha ou email invalidos');
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyles.textTile,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'E-mail'),
                          controller: _emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Email Obrigatorio'),
                            Validatorless.email('E-mail inválido'),
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _passwordEC,
                          decoration: const InputDecoration(labelText: 'Senha'),
                          validator:
                              Validatorless.required('Senha Obrigatória'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: DeliveryButton(
                            width: double.infinity,
                            label: 'ENTRAR',
                            onPressed: () {
                              var valid =
                                  _formKey.currentState?.validate() ?? false;

                              if (valid) {
                                controller.login(
                                  _emailEC.text,
                                  _passwordEC.text,
                                );
                              }
                            },
                          ),
                        )
                      ],
                    )),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não possui uma conta ?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/auth/register');
                    },
                    child: Text(
                      'Cadastre-se',
                      style: TextStyles.textExtraBold.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
