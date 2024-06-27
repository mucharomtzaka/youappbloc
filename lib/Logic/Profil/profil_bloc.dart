import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/ProfilApi.dart';
import '../../Repository/ServicesApi.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent,ProfilState>{
   ServicesApi servicesApi;
   var log = Logger();
  ProfilBloc({required this.servicesApi}) : super(ProfilInitial()){
    on<GetProfil>((event, emit) async{
      emit(ProfilLoading());
      try{
          var pref = await SharedPreferences.getInstance();
          final result = await servicesApi.getProfil(token: pref.getString("token").toString());
           log.i(result.data);
          if(result.statusCode == 200){
           
            emit(ProfilLoaded(model: ProfilApi.fromJson(jsonDecode(result.data))));
          }else{
            emit(ProfilError(error: result.data['message']));
          }
      }catch(e){
        if (e is DioException) {
           if(e.response?.statusCode == 500){
            Map<String, dynamic>? responseMap =
                e.response?.data as Map<String, dynamic>?;
            String errorMessage = responseMap?['message'] ?? [];
            emit(ProfilError(error: errorMessage));
          }
        }else{
          emit(ProfilError(error: e.toString()));
        }
      }
    });
  }
}
