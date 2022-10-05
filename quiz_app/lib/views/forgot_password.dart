import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/widgets/widgets.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController ForgotPassword= TextEditingController();
  final _formkey =GlobalKey<FormState>();
  late String email;
  @override
 void dispose(){
  ForgotPassword.dispose();
 }
  Future reset()async{
    try {
      if(_formkey.currentState!.validate()){
   await FirebaseAuth.instance.sendPasswordResetEmail(email: ForgotPassword.text.trim());
   showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Reset password link sent to your email"),
        );
      });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
          );
          
      });
      Future.delayed(Duration(seconds: 4),(){
        Navigator.pop(context);
      });
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor:Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
      ),
      body: Form(
     key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Recive an emial to reset your password',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25,),textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: ForgotPassword,
                   validator: (val){
                    if(val!.isEmpty){
                      return 'Enter Email';
                    }
                    if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                        return 'Enter a valid Email';
                      }
                    
                      return null;
                    },
                  
                  decoration: InputDecoration(
                  hintText: 'Em@il',
                      ),
                      onChanged: (val){
                    email= val;
                  },
                    
                  ),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              child: Button(context:context,label: "Reset Password"),
              onTap: (){
             reset();
              },
            )
          ],
        )),
    );
  }
}