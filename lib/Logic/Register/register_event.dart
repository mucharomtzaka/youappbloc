part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class TryRegister extends RegisterEvent {
  final String email,username, password;
  const TryRegister({
    required this.email,
    required this.username,
    required this.password,
  });
}
