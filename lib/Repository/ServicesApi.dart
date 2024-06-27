// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'package:dio/dio.dart';

class ServicesApi{
  /// base url api
  String  baseUrl = "https://techtest.youapp.ai";
  final Dio dioClient;
  ServicesApi({
    required this.dioClient,
  });
  
 // service api login
 Future<Response> login(
      {required String email, required String password}) async {
      Response response = await dioClient.post(
            "$baseUrl/api/login",
            options: Options(
              headers: {
                "Content-Type": "application/json",
              },
            ),
            data: {
              "email": email,
              "username":email,
              "password": password,
            },
          );
    return response;
  }

//services api register
   Future<Response> Register(
      {required String email,required username, required String password}) async {
      Response response = await dioClient.post(
            "$baseUrl/api/register",
            options: Options(
              headers: {
                "Content-Type": "application/json",
              },
            ),
            data: {
              "email": email,
              "username":username,
              "password": password,
            },
          );
    return response;
  }

}