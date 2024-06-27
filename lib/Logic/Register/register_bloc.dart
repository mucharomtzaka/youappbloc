import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:equatable/equatable.dart';
import '../../Repository/ServicesApi.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  ServicesApi servicesApi;
  var log = Logger();
  RegisterBloc({required this.servicesApi}) : super(RegisterInitial()){
    on<TryRegister>((event, emit) async {
      emit(RegisterLoading());
      try{
        final result = await servicesApi.Register(email: event.email, username: event.username, password: event.password);
        if(result.statusCode == 201){
          Map<String,dynamic> data = result.data;
           if(data['message'].toString().contains("User already exists")){
            emit(RegisterError(error: data['message']));
           }else{
            emit(RegisterLoaded(message:data['message']));
           } 
        }
      }catch(e){
        if (e is DioException) {
           if(e.response?.statusCode == 400){
            Map<String, dynamic>? responseMap =
                e.response?.data as Map<String, dynamic>?;
            List<dynamic> errorMessage = responseMap?['message'] ?? [];
            emit(RegisterError(error: errorMessage.first));
          }
        }else{
          emit(RegisterError(error: e.toString()));
        }
      }
    });
  }
}