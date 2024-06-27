part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final String message;
  const RegisterLoaded({
    required this.message,
  });
}

class RegisterError extends RegisterState {
  final String error;
  const RegisterError({
    required this.error,
  });
}