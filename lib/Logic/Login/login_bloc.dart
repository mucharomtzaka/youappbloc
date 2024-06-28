// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Repository/ServicesApi.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ServicesApi servicesApi;
   var log = Logger();
  LoginBloc({required this.servicesApi}) : super(LoginInitial()) {
    on<TryLogin>((event, emit) async {
      emit(LoginLoading());
      try{
        var pref = await SharedPreferences.getInstance();
        final result = await servicesApi.login(email: event.email, password: event.password);
        log.i(result.data);
        if(result.statusCode == 201){
          Map<String,dynamic> data = result.data;
          if(data['access_token'] != null){
            pref.setBool("login", true);
            pref.setString("token",data['access_token']);
            emit(LoginLoaded());
          }else{
            emit(LoginError(error: data['message']));
          }
        }
      }catch(e){
        if (e is DioException) {
           if(e.response?.statusCode == 400){
            Map<String, dynamic>? responseMap =
                e.response?.data as Map<String, dynamic>?;
            List<dynamic> errorMessage = responseMap?['message'] ?? [];
            emit(LoginError(error: errorMessage.first));
          }
        }else{
          emit(LoginError(error: e.toString()));
        }
      }
    });
    
    on<Logout>((event, emit) async {
      emit(LoginLoading());
      var pref = await SharedPreferences.getInstance();
      pref.clear();
      emit( LoginInitial());
    });
  }
}