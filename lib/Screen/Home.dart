// ignore_for_file: unused_local_variable
import 'package:cached_network_image/cached_network_image.dart';
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
                         
                       }
                     },
            builder: (operationsContext, operationsState) {
                  if(operationsState is ProfilError){
                    context.read<LoginBloc>().add(Logout());
                  }
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
                          Text(operationsState is ProfilLoaded ? "@${operationsState.model.data.username}" : "@test",style: const TextStyle(color: Colors.white,fontSize: 14),),
                          IconButton(onPressed: (){
                          }, icon: const Icon(Icons.more_horiz,color: Colors.white,))
                      ],),
                      const SizedBox(height: 10,),
                      Stack(
                          children: [
                      CachedNetworkImage(
                        imageUrl: "https://cmsc426.github.io/assets/pano/delicate-arch-pano.jpg",
                        imageBuilder: (context, imageProvider) =>  Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: HexColor("#1F4247"),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ) ,
                      errorWidget: (context, url, error) => Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: HexColor("#1F4247"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: HexColor("#1F4247"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox(),
                      )),
                      Positioned(
                              left: 10,
                              bottom: 10,
                              child: Text(operationsState is ProfilLoaded ?  "@${operationsState.model.data.username}," : "@test,",style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),)),
                          ],
                        ),
                      const SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: HexColor("#09141A"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             const Text('About',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                              IconButton(onPressed: (){

                              }, icon: const Icon(Icons.edit,color: Colors.white))
                            ],
                          ),
                          const SizedBox(height: 10,),
                          operationsState is ProfilLoaded ? operationsState.model.data.birthday.isNotEmpty && operationsState.model.data.horoscope.isNotEmpty 
                          && operationsState.model.data.height == 0 && operationsState.model.data.weight == 0
                          ? const Text("Add in your your to help others know you better",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),) : const SizedBox() : const SizedBox(),
                           operationsState is ProfilLoaded ? operationsState.model.data.birthday.isEmpty ? const SizedBox() : Text("Birthday : ${operationsState.model.data.birthday}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
                           operationsState is ProfilLoaded ? operationsState.model.data.horoscope.isEmpty ? const SizedBox() : Text("Horoscope : ${operationsState.model.data.horoscope}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
                           operationsState is ProfilLoaded ? operationsState.model.data.height == 0 ? const SizedBox() : Text("Height : ${operationsState.model.data.height} cm",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
                           operationsState is ProfilLoaded ? operationsState.model.data.weight == 0 ? const SizedBox() : Text("Weight : ${operationsState.model.data.weight} kg",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox()
                        ],),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: HexColor("#09141A"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Interest',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                              IconButton(onPressed: (){

                              }, icon: const Icon(Icons.edit,color: Colors.white))
                            ],
                          ),
                          const SizedBox(height: 20,),
                          operationsState is ProfilLoaded ?
                          operationsState.model.data.interests.isNotEmpty ?
                           Row(
                            children: operationsState.model.data.interests.map((e)=>
                             Container(
                              padding: const EdgeInsets.all(14),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                          color: HexColor("#1F4247"),
                          borderRadius: BorderRadius.circular(10),
                        ),
                               child: Text(e,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                              ),
                            ).toList(),
                          ) : const Text('Add in your interest to find a better match',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),) : 
                         const SizedBox(),
                        ],),
                      ),
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