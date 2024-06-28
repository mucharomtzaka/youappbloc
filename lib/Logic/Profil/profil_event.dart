part of 'profil_bloc.dart';

class ProfilEvent extends Equatable {
  const ProfilEvent();
  @override
  List<Object> get props => [];
}
class GetProfil extends ProfilEvent {}

class EditProfil extends ProfilEvent {
  final String displayname, birthday,height,weight;
  const EditProfil({
    required this.displayname,
    required this.birthday,
    required this.height,
    required this.weight
  });
}