import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/base_state/base_state.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/styles/text_styles.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_app_bar.dart';
import 'package:vaquinha_burger_provider_bloc/app/core/ui/widgets/delivery_button.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/register/controller/register_controller.dart';
import 'package:vaquinha_burger_provider_bloc/app/pages/home/auth/register/controller/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _senhaEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          error: () {
            hideLoader();
            showError('Erro ao realizar Login');
          },
          register: () => showLoader(),
          sucess: () {
            hideLoader();
            showSucess('Cadastro realizado com Sucesso');
            Navigator.of(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: TextStyles.textTile,
                  ),
                  Text(
                    'Preecha os campos abaixo para criar o seu cadastro',
                    style: TextStyles.textMedium.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _nameEC,
                    validator: Validatorless.required('Nome Obrigatório'),
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailEC,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail Obrigatório'),
                      Validatorless.email('E-mail invalido'),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _senhaEC,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatório'),
                        Validatorless.min(6, 'minimo 6 caracteres'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirmar Senha'),
                    validator:
                        Validatorless.compare(_senhaEC, 'Senha não confere'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      label: 'Cadastrar',
                      onPressed: () {
                        var valid = _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                              _nameEC.text, _emailEC.text, _senhaEC.text);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
