// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Logic/Profil/profil_bloc.dart';
import '../Logic/Login/login_bloc.dart';
import '../Widget/helper.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     context.read<ProfilBloc>().add(GetProfil());
    return Scaffold(
             body: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if(state is LoginInitial){
                    String data = "Logout Success";
                            WidgetHelper.showSnackBarFun(context, data, Colors.green);
                    Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                  }
                },
                builder: (context, state) {
                   return BlocConsumer<ProfilBloc, ProfilState>(
                     listener: (operationsContext, operationsState) {
                       if(operationsState is ProfilError){
                         String data = operationsState.error;
                            WidgetHelper.showSnackBarFun(operationsContext, data, Colors.red);
                       }
                     },
            builder: (operationsContext, operationsState) {
                 return Container(
                height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [
                            HexColor("#1F4247"),
                            HexColor("#0D1D23"),
                            HexColor("#09141A")],
                        ),
                      ),
                      child:  ListView(
                    padding: const EdgeInsets.all(14),
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            GestureDetector(
                            child: const Row(
                              children: [
                              Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                              Text("Back",style: TextStyle(color: Colors.white,fontSize: 14),),
                            ],),
                            onTap: (){
                              context.read<LoginBloc>().add(Logout());
                            },
                          ),
                          Text(operationsState is ProfilLoaded ? operationsState.model.data.username.toString() : "test",style: const TextStyle(color: Colors.white,fontSize: 14),),
                          IconButton(onPressed: (){
                          }, icon: const Icon(Icons.more_horiz,color: Colors.white,))
                      ],),
                      const SizedBox(height: 10,),
                    ],
                  ),
              );
            },
          );
        },
      ),
    );
  }
}