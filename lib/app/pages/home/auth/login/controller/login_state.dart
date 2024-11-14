// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'login_state.g.dart';

@match
enum LoginStatus {
  initial,
  login,
  loginError,
  error,
  success,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? messageError;

  const LoginState({
    required this.status,
    this.messageError,
  });
  const LoginState.initial()
      : status = LoginStatus.initial,
        messageError = null;

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        messageError,
      ];

  LoginState copyWith({
    LoginStatus? status,
    String? messageError,
  }) {
    return LoginState(
      status: status ?? this.status,
      messageError: messageError ?? this.messageError,
    );
  }
}
