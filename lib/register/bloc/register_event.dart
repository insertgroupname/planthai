import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RegisterEmailChanged { email :$email }';
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RegisterPasswordChanged { password: $password }';
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;
  final String password;

  RegisterConfirmPasswordChanged(
      {@required this.confirmPassword, @required this.password});

  @override
  List<Object> get props => [confirmPassword, password];

  @override
  String toString() =>
      'RegisterConfirmPasswordChanged { RegisterConfirmPassword: $confirmPassword }';
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  RegisterSubmitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'RegisterSubmitted { email: $email, password: $password }';
  }
}
