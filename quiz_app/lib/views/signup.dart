import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/sharedprefarance/constants.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/widgets/widgets.dart';
class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   final _formkey =GlobalKey<FormState>();
  late String  name,email,password, confirmpassword; 
  TextEditingController namecontroller =TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmpasswordController=TextEditingController();

  AuthService authservice= AuthService();
  bool _isloading=false;
  signup(){
    if(_formkey.currentState!.validate()){
      setState(() {
        _isloading= true;
      });
    authservice.signUpWithEmailAndPassword(email, password).then((value){
        if(value!=null){
          setState(() {
            _isloading=false;
          });
          Helperlogdetails.saveuserlogindetails(isloggedin: true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0.0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
       
        ),
        body:_isloading?  Container(
          child: Center(
            child: CircularProgressIndicator(color:Color.fromARGB(255, 23, 82, 131),strokeWidth: 5.5,),
          ),
        ): Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Spacer(),
            TextFormField(
              keyboardType: TextInputType.name,
                 controller: namecontroller,
                  validator: (val){return val!.isEmpty?"Enter Name": null;},
                  decoration: InputDecoration(
                  hintText: 'Name',
                    ),
                  onChanged: (val){
                    name= val;
                  },
            ),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (val){return val!.isEmpty?"Enter Email": null;},
                  decoration: InputDecoration(
                  hintText: 'Email',
                    ),
                  onChanged: (val){
                    email= val;
                  },
                ),

               
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
                TextFormField(
                  obscureText: true,
                  controller: confirmpasswordController,
                  validator: (val){
                      if(val!.isEmpty)
                      {
                        return 'Please re-enter password';
                      }
                          print(passwordController.text);

                      print(confirmpasswordController.text);
                        if(passwordController.text!=confirmpasswordController.text){
                        return "Password does not match";
                      }
                      
                      return null;
                    },
                  decoration: InputDecoration(
                  hintText: 'Confirm-Password',
                    ),
                  onChanged: (val){
                    password= val;
                  },
                ),
               
                SizedBox(height: 15),
                GestureDetector(
                  onTap: (){
                    signup();
                  },
                  child: Button(context:context,label:"Signup")
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: TextStyle(fontSize: 15),),
                    SizedBox(width: 4,),
                    GestureDetector(
                      onTap:(){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                      },
                      child: Text("sign in",style: TextStyle(fontSize: 15,color: Colors.green,decoration: TextDecoration.underline),))

                  ],
                ),
                
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
    );
  }
}