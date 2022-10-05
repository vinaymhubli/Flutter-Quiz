import 'package:flutter/material.dart';
import 'package:quiz_app/services/cloud_database.dart';
import 'package:quiz_app/views/add_question.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';
class AddQuiz extends StatefulWidget {
  AddQuiz({Key? key}) : super(key: key);

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  DatabaseService databaseService = DatabaseService();
  bool _isloading=false;
  UploadQuiz()async{
   if(_formkey.currentState!.validate()){
    setState(() {
      _isloading=true;
    });
    quizId=randomAlphaNumeric(16);
    Map<String, String> quizMap={
      "quizId": quizId,
      "quizimageurl":quizimageurl,
      "quiztitle":quiztitle,
      "quizdesc":quizdesc
    };
    await databaseService .addQuizData(quizMap, quizId).then((value) {
      setState(() {
        _isloading=false;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddQuestion(quizId)));
      });
    });
   }
  }
  late String quizimageurl,quiztitle,quizdesc,quizId;
  final _formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0.0,
        centerTitle: true,
        title: appBar(context),
       iconTheme: IconThemeData(color: Colors.black),
        ),
        body: _isloading?Container( child: Center(
            child: CircularProgressIndicator(color:Color.fromARGB(255, 23, 82, 131),strokeWidth: 5.5,),
          )):      Form(key: _formkey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
       child: Column(
        children: [
          TextFormField(
            validator: (val)=>val!.isEmpty?"Enter url":null,
            decoration: InputDecoration(  
              hintText: 'Attach quiz image',
            ),
            onChanged: (val){quizimageurl=val;},
          ),

           TextFormField(
            validator: (val)=>val!.isEmpty?"Enter title":null,
            decoration: InputDecoration(  
              hintText: 'Name of the quiz',
            ),
            onChanged: (val){quiztitle=val;},
          ),
          TextFormField(
            validator: (val)=>val!.isEmpty?"Enter description":null,
            decoration: InputDecoration(  
              hintText: 'Quiz description',
            ),
            onChanged: (val){quizdesc=val;},
          ),
          Spacer(),
          GestureDetector(
            onTap: (){UploadQuiz();},
            child: Button( context:context,label: "Create Quiz")),
          SizedBox(height: 10,),
        ],
       ),
        )),

      
    );
  }
}