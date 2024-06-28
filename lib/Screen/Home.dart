// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_constructors_in_immutables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
 

  bool EditProfile = false;
  
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();
  TextEditingController displayname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController horoscope = TextEditingController(); 
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void refreshdata(context){
    context.read<ProfilBloc>().add(GetProfil());
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProfilBloc>(context);
    bloc.add(GetProfil());
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
                    bloc: bloc,
                     listener: (operationsContext, operationsState) {
                       if(operationsState is ProfilLoaded){
                         
                         displayname.text = operationsState.model.data.username;
                         birthday.text = operationsState.model.data.birthday;
                         height.text = operationsState.model.data.height.toString();
                         weight.text = operationsState.model.data.weight.toString();
                       }
                       if(operationsState is ProfilSuccess){
                         String data = operationsState.success;
                            WidgetHelper.showSnackBarFun(context, data, Colors.green);
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
                      physics: const BouncingScrollPhysics(),
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
                        child: Form(
                          key: formKeyEdit,
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const Text('About',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                               EditProfile == false ? IconButton(onPressed: (){
                                  setState(() {
                                    EditProfile = !EditProfile;
                                  });
                                }, icon: const Icon(Icons.edit,color: Colors.white)) : TextButton(onPressed: () async{
                        
                                  if(formKeyEdit.currentState!.validate()){
                                    bloc.add(EditProfil(displayname: displayname.text, birthday: birthday.text, height: height.text, weight: weight.text));
                                   
                                    setState(() {
                                      EditProfile = !EditProfile;
                                    });

                                     WidgetsBinding.instance.addPostFrameCallback((callback){
                                      refreshdata(context);
                                    });
                                  }                      
                                }, child: const Text("Save & Update",style: TextStyle(color: Colors.white),))
                              ],
                            ),
                            const SizedBox(height: 10,),
                            operationsState is ProfilLoaded ? operationsState.model.data.birthday.isNotEmpty && operationsState.model.data.horoscope.isNotEmpty 
                            && operationsState.model.data.height == 0 && operationsState.model.data.weight == 0
                            ? const Text("Add in your your to help others know you better",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),) : const SizedBox() : const SizedBox(),

                             EditProfile == true ? _widgetEditProfile(operationsState,context) : _widgetProfile(operationsState)
                          ],),
                        ),
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
  
  _widgetEditProfile(ProfilState operationsState,BuildContext context) {
  
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
             const Text('Display name', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
             const SizedBox(width: 30,),
             Expanded(
               child: TextFormField(
                textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.white),
                        controller: displayname,
                        keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required !';
                                }
                                return null;
                              }, decoration: InputDecoration(
                                labelStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                hintText: "Enter Name",
                                hintStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                errorStyle: const TextStyle(color: Colors.white),
                                focusColor: Colors.white
                              ),
                      ),
             ),        
          ],),
          const SizedBox(height: 10,),
          Row(children: [
             const Text('Birthday', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
             SizedBox(width: MediaQuery.of(context).size.width/6.5,),
             Expanded(
               child: TextFormField(
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.white),
                        controller: birthday,
                        keyboardType: TextInputType.text,
                              validator: (value) {
                                return null;
                              }, decoration: InputDecoration(
                                labelStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                hintText: "DD MM YYYY",
                                hintStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                errorStyle: const TextStyle(color: Colors.white),
                                focusColor: Colors.white
                              ),
                      ),
             ),
                    
          ],),
          const SizedBox(height: 10,),
          Row(children: [
             const Text('Height', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
             SizedBox(width: MediaQuery.of(context).size.width/5.3,),
             Expanded(
               child: TextFormField(
                textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.white),
                        controller: height,
                        keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Height is required !';
                                }
                                return null;
                              }, decoration: InputDecoration(
                                labelStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                hintText: "Add Height",
                                hintStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                errorStyle: const TextStyle(color: Colors.white),
                                focusColor: Colors.white
                              ),
                      ),
             ),
                    
          ],),
          const SizedBox(height: 10,),
          Row(children: [
             const Text('Weight', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
             SizedBox(width: MediaQuery.of(context).size.width/5.3,),
             Expanded(
               child: TextFormField(
                textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.white),
                        controller: weight,
                        keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Weight is required !';
                                }
                                return null;
                              }, decoration: InputDecoration(
                                labelStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                hintText: "Add Weight",
                                hintStyle: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                errorStyle: const TextStyle(color: Colors.white),
                                focusColor: Colors.white
                              ),
                      ),
             ),
                    
          ],),
        ],
      );
  }
  
  _widgetProfile(ProfilState operationsState) {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        operationsState is ProfilLoaded ? operationsState.model.data.birthday.isEmpty ? const SizedBox() : Text("Birthday : ${operationsState.model.data.birthday}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
        operationsState is ProfilLoaded ? operationsState.model.data.horoscope.isEmpty ? const SizedBox() : Text("Horoscope : ${operationsState.model.data.horoscope}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
        operationsState is ProfilLoaded ? operationsState.model.data.height == 0 ? const SizedBox() : Text("Height : ${operationsState.model.data.height} cm",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
        operationsState is ProfilLoaded ? operationsState.model.data.weight == 0 ? const SizedBox() : Text("Weight : ${operationsState.model.data.weight} kg",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)  : const SizedBox(),
      ],
    );
  }
}