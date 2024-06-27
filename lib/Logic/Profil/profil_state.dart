part of 'profil_bloc.dart';

class ProfilState extends Equatable {
  const ProfilState();

  @override
  List<Object> get props => [];
}

class ProfilInitial extends ProfilState {}

class ProfilLoading extends ProfilState {}

class ProfilLoaded extends ProfilState {
 final ProfilApi model;
  const ProfilLoaded({
    required this.model,
  });
}

class ProfilError extends ProfilState {
  final String error;
  const ProfilError({
    required this.error,
  });
}