
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
          final result = await servicesApi.getProfil(token: pref.getString("token")!);
           log.i(result.data);
          if(result.statusCode == 200){
            
            Map<String,dynamic> responseMap = jsonDecode(jsonEncode(result.data)); 

            if(responseMap['data']['horoscope'] == null){
              responseMap['data']['horoscope'] = "";
            }

            if(responseMap['data']['birthday'] == null){
              responseMap['data']['birthday'] = "";
            }

            if(responseMap['data']['name'] == null){
              responseMap['data']['name'] = "";
            }

            if(responseMap['data']['zodiac'] == null){
              responseMap['data']['zodiac'] = "";
            }

            if(responseMap['data']['height'] == null){
              responseMap['data']['height'] = 0;
            }
            if(responseMap['data']['weight'] == null){
              responseMap['data']['weight'] = 0;
            }
            
            log.i(responseMap);

            Map<String,dynamic> responseMapx = jsonDecode(jsonEncode(responseMap)); 
            emit(ProfilLoaded(model: ProfilApi.fromJson(responseMapx)));
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
    on<EditProfil>((event,emit) async{
       emit(ProfilLoading());
       try{
        var pref = await SharedPreferences.getInstance();
        final result = await servicesApi.EditProfils(displayname: event.displayname, birthday: event.birthday, height: int.parse(event.height), weight: int.parse(event.weight),token: pref.getString("token")!);
        log.i(result.data);
        if(result.statusCode == 200){
          Map<String,dynamic> responseMap = jsonDecode(jsonEncode(result.data));
          emit(ProfilSuccess(success: responseMap['message']));
        }else{
          emit(ProfilError(error: result.data['message']));
        }
       }catch(e){
        if (e is DioException) {
           if(e.response?.statusCode == 401){
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
    
    on<AddInterest>((event,emit) async{
      emit(ProfilLoading());
      try{
         var pref = await SharedPreferences.getInstance();
         final result = await servicesApi.EditInterest(interest:event.interest,token: pref.getString("token")!);
         if(result.statusCode == 200){
          Map<String,dynamic> responseMap = jsonDecode(jsonEncode(result.data));
          emit(ProfilSuccess(success: responseMap['message']));
        }else{
          emit(ProfilError(error: result.data['message']));
        }
      }catch(e){
        if (e is DioException) {
           if(e.response?.statusCode == 401){
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
