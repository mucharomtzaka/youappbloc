// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/Screen/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Logic/Login/login_bloc.dart';
import '../Widget/dialog/show_info_dialog.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(); 
  bool visible_password = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth(context);
  }

  void checkAuth(context) async {
    var pref = await SharedPreferences.getInstance();
     if(pref.getBool('login') == true){
      if(mounted){
        Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Home()),);
      }
     }
  }

  @override
  Widget build(BuildContext context) {
    var login = context.read<LoginBloc>();
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: login,
        listener: (context, state) async {
                if (state is LoginLoaded) {
                  
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Home()),
                    );
                  }
                  else if (state is LoginError) {
                    await showInfoDialog(
                        title: "Error",
                        message: state.error,
                        buildContext: context);
                  }
        },
        builder: (context, state)  {
          return Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
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
                  const SizedBox(height: 50,),
                  const Text("Login",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w700,fontSize: 24),),
                  const SizedBox(height: 15,),
                  TextFormField(
                    key: const Key('emaillogin'),
                    style: const TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username / Email is required !';
                            }
                            return null;
                          }, decoration: InputDecoration(
                            labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                            hintText: "Enter Username / Email",
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
                  const SizedBox(height: 15,), 
                  TextFormField(
                     key: const Key('passwordlogin'),
                    style: const TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: visible_password,
                    keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required !';
                            }
                            return null;
                          }, decoration: InputDecoration(
                            labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w700,color: Colors.white),
                            hintText: "Enter Password",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w700,color: Colors.white),
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(icon: visible_password == false ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),onPressed: (){
                              setState(() {
                                visible_password = !visible_password;
                              });
                            },)
                          ),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    key: const Key("btnLogin"),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                      decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: [HexColor("#62CDCB"), HexColor("#4599DB")]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        login.add(TryLogin(
                                  email: emailController.text, password: passwordController.text));
                      }
                    },
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No account?",style: TextStyle(color: Colors.white),),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        key: const Key('btnRegister'),
                      child:  Text("Register here",style: TextStyle(color: HexColor("#FFD700")),
          
                      ),onTap: (){
        Navigator.push(
                          context,MaterialPageRoute(builder: (_) => const Register()));
                      },)
                    ],
                  )
                ],
              ),
          ),
        );
        },
      )
    );
  }
}