import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/sharedprefarance/constants.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
 Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp( MyApp());
  }
class MyApp extends StatefulWidget {
 

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isloggedin=false;
  @override
  void initState() {
   checkuserlogin();
    super.initState();
  }
  checkuserlogin()async{
   Helperlogdetails.getuserlogindetails().then((value){
    setState(() {
      _isloggedin=value!;
    });
   });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_Quiz_App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(  
        primaryColor: Colors.redAccent
      ),
      home: (_isloggedin) ?QuizHome():  SignIn(),
    );
  }
}