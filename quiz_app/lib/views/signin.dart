import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/sharedprefarance/constants.dart';
import 'package:quiz_app/views/forgot_password.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:quiz_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final _formkey =GlobalKey<FormState>();
  late String email,password; 
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  AuthService authservice= AuthService();
  bool _isloading=false;
  
  signin()async{
    if(_formkey.currentState!.validate()){

      setState(() {
        _isloading= true;
      });
   await authservice.signInEmailAndPass(context,email, password).then((value){
    if(value!=null){
        setState(() {
     _isloading=false;
   });
   Helperlogdetails.saveuserlogindetails(isloggedin: true);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuizHome()));
    }
   });
 
   
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light
        ),),
        body: _isloading?  Container(
          child: Center(
            child: CircularProgressIndicator(color:Color.fromARGB(255, 23, 82, 131),strokeWidth: 5.5,),
          ),
        ):Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Spacer(),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  hintText: 'Email',
                    ),
                  onChanged: (val){
                    email= val;
                  },
                ),

                SizedBox(height: 7,),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (val){return val!.isEmpty?"Enter Password": null;},
                  decoration: InputDecoration(
                  hintText: 'Password',
                    ),
                  onChanged: (val){
                    password= val;
                  },
                ),
                SizedBox(height: 10),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>ForgotPassword()));
                    },
                    child: Text('Forgot Password?',style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),),
                  )
                ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: (){
                  signin();
                  },
                  child: Button(context:context,label: "Sign-In")
                ),
                SizedBox(height: 17),
               
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?",style: TextStyle(fontSize: 15),),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: Text("signup",style: TextStyle(fontSize: 15,color: Colors.red,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),))

                  ],
                ),
                
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
    );
  }
}
