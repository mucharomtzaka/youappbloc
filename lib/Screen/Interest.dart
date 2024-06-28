import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../Logic/Profil/profil_bloc.dart';
import '../Widget/helper.dart';
import 'package:textfield_tags/textfield_tags.dart';


class Interest extends StatefulWidget {
  const Interest({super.key});
  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProfilBloc>(context);
    bloc.add(GetProfil());
    final Shader linearGradient = LinearGradient(
      colors: [
          HexColor("#94783E"),
          HexColor("#F3EDA6"),
          HexColor("#F8FAE5"),
          HexColor("#FFE2BE"),
          HexColor("#D5BE88"),
          HexColor("#F8FAE5"),
          HexColor("#D5BE88"),
         ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    List<String> tags = [];
    return Scaffold(
      body: BlocConsumer<ProfilBloc, ProfilState>(
         bloc: bloc
        , listener: (BuildContext context, ProfilState operationsState) { 
          if(operationsState is ProfilSuccess){
                         String data = operationsState.success;
                            WidgetHelper.showSnackBarFun(context, data, Colors.green);
                       }
                       if(operationsState is ProfilError){
                         String data = operationsState.error;
                            WidgetHelper.showSnackBarFun(context, data, Colors.red);
                             Navigator.pop(context);
                       }
                       if(operationsState is ProfilLoaded){
                         var data = operationsState.model.data.interests;
                         if(data.isNotEmpty){
                            tags.clear();
                            tags.addAll(data);
                         }
                       }

                      if(operationsState is ProfilSuccess){
                         String data = operationsState.success;
                            WidgetHelper.showSnackBarFun(context, data, Colors.green);
                            Navigator.pop(context);
                       }

         }, builder: (BuildContext context, ProfilState operationsState) {
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
                             Navigator.pop(context);
                            },
                          ),
                          TextButton(onPressed: (){
                            bloc.add(AddInterest(interest: tags));
                          }, child: const Text("Save",style: TextStyle(color: Colors.white),))
                      ],),
                          const SizedBox(height: 50,),
                          Text("Tell everyone about yourself",style: TextStyle(fontSize: 14,foreground: Paint()..shader = linearGradient,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 20,),
                          const Text('What interest you?',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),),
                          const SizedBox(height: 20,),
                          TextFieldTags(
                            textSeparators: const [ 
                                " ", //seperate with space
                                ',' //sepearate with comma as well   
                            ],
                            initialTags: tags,
                            onTag: (tag){
                                //this will give tag when entered new single tag
                                tags.add(tag);
                            },
                            onDelete: (tag){
                                //this will give single tag on delete
                                tags.remove(tag);
                            },
                            validator: (tag){
                                //add validation for tags
                                if(tag.length < 3){
                                    return "Enter tag up to 3 characters.";
                                }
                                return null;
                            },
                            tagsStyler: TagsStyler( //styling tag style
                                tagTextStyle: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),
                                  tagDecoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(0.0), ),
                                  tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.blue[900]),
                                  tagPadding:const  EdgeInsets.all(6.0)
                            ),
                            textFieldStyler: TextFieldStyler( 
                                  hintText: '',//styling tag text field
                                  textStyle: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),
                                  textFieldBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 2)
                                  )
                            ),
                          ),
                        ]
                      ),
          );
        },
    ));
}
}