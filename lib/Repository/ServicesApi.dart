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

  // fetch profils
  Future<Response> getProfil(
      {required String token}) async {
      Response response = await dioClient.get(
            "$baseUrl/api/getProfile",
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "x-access-token": token
              },
            ),
          );
    return response;
  }

  //edit profils 
  Future<Response> EditProfils(
      {required String displayname,required String birthday, required int height,required int weight,required String token}) async {
      Response response = await dioClient.put(
            "$baseUrl/api/updateProfile",
            options: Options(
              headers: {
                "Content-Type": "application/json",
                 "x-access-token": token
              },
            ),
            data: {
              "name": displayname,
              "birthday":birthday,
              "height": height,
              "weight":weight,
              "interests": []
            },
          );
    return response;
  }
}