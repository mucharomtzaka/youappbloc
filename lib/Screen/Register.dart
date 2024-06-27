import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/Screen/Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController confirmaController = TextEditingController();

  final formKey = GlobalKey<FormState>(); 
  bool visible_password = true;
  bool visible_confirmpass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    HexColor("#1F4247"),
                    HexColor("#0D1D23"),
                    HexColor("#09141A")],
                    radius: 0.75,
                ),
              
              ),
            child: Column(children: [
              const SizedBox(height: 20,),
              GestureDetector(
                child: const Row(
                  children: [
                  Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                  Text("Back",style: TextStyle(color: Colors.white,fontSize: 14),),
                ],),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10,),
              Expanded(child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  const SizedBox(height: 50,),
                  const Text("Register",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.w700,fontSize: 24),),
                  const SizedBox(height: 15,),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required !';
                            }
                            return null;
                          }, decoration: InputDecoration(
                            labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                            hintText: "Enter Email",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.white)
                          ),
                  ),
                  const SizedBox(height: 15,), 
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: UsernameController,
                    keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required !';
                            }
                            return null;
                          }, decoration: InputDecoration(
                            labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                            hintText: "Create username",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w500,color: Colors.white),
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.white)
                          ),
                  ),
                  const SizedBox(height: 15,), 
                  TextFormField(
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
                            hintText: "Create Password",
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
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: confirmaController,
                    obscureText: visible_confirmpass,
                    keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password is required !';
                            }
                            if(confirmaController.text != value){
                              return 'Confirm Password not match with create password  !';
                            }
                            return null;
                          }, decoration: InputDecoration(
                            labelStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w700,color: Colors.white),
                            hintText: "Confirm Password",
                            hintStyle: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w700,color: Colors.white),
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(icon: visible_confirmpass == false ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),onPressed: (){
                              setState(() {
                                visible_confirmpass = !visible_confirmpass;
                              });
                            },)
                          ),
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                      decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: [HexColor("#62CDCB"), HexColor("#4599DB")]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    onTap: (){
                      if(formKey.currentState!.validate()){
                      }
                    },
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?",style: TextStyle(color: Colors.white),),
                      const SizedBox(width: 10,),
                      GestureDetector(child:  Text("Login here",style: TextStyle(color: HexColor("#FFD700")),
                      ),onTap: (){
                        Navigator.push(
                          context,MaterialPageRoute(builder: (_) => const Login()));
                      },)
                    ],
                  )
                ],
              ))
            ],),
          ),
                ),
    );
  }
}