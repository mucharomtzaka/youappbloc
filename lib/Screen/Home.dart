import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Logic/Login/login_bloc.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var login = context.read<LoginBloc>();
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: login,
        listener: (context, state) {
          if(state is LoginInitial){
            Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login()),
                    );
          }
        },
        builder: (context,state){
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
                child: ListView(
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
                            login.add(Logout());
                          },
                        ),
                        Text("Andi",style: TextStyle(color: Colors.white,fontSize: 14),),
                        IconButton(onPressed: (){
                        }, icon: const Icon(Icons.more_horiz,color: Colors.white,))
                     ],),
                    const SizedBox(height: 10,),
                  ],
                ),
        );
        },
      )
    );
  }
}