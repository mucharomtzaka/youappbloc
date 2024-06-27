import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Repository/ServicesApi.dart';
import 'package:myapp/Screen/Login.dart';
import 'package:myapp/data/observer/bloc_observer.dart';
import 'Logic/Login/login_bloc.dart';
import 'Logic/Register/register_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    ServicesApi servicesApi = ServicesApi(dioClient: dio);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(servicesApi: servicesApi),
        ),
         BlocProvider(
          create: (context) => RegisterBloc(servicesApi: servicesApi),
        ),
      ],
      child: MaterialApp(
        title: 'YouApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const Login(),
      ),
    );
  }
}

