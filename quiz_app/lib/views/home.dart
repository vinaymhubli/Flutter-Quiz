import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/bot/bot_home.dart';
import 'package:quiz_app/services/cloud_database.dart';
import 'package:quiz_app/views/add_quiz.dart';
import 'package:quiz_app/views/quiz.dart';
import 'package:quiz_app/widgets/widgets.dart';

class QuizHome extends StatefulWidget {
  QuizHome({Key? key}) : super(key: key);
 @override
  State<QuizHome> createState() => _QuizHomeState();
}
class _QuizHomeState extends State<QuizHome> {
  DatabaseService databaseService = DatabaseService();
    Stream ?quizStream;
  Widget Quizlist(){
  return Container(
    margin: EdgeInsets.symmetric(horizontal:24 ),
    child: Column(
      children: [
        StreamBuilder(stream: quizStream,
          builder: (context,AsyncSnapshot snapshot){
         return snapshot.data ==null?Container():
         ListView.builder(shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
         return Quiztile(imageurl: snapshot.data.docs[index].data()["quizimageurl"],
         desc: snapshot.data.docs[index].data()["quizdesc"],
           title:snapshot.data.docs[index].data()["quiztitle"] ,
           quizid: snapshot.data.docs[index].data()["quizId"],

         );
          });
        }),
       SizedBox(height: 20,),
       GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>BotHome()));
        },
         child: Container(
          height: 80.0,
          child: Image(image: AssetImage('assets/bot.gif'),)
         ),
       ),
       Container(
        child: Text('Help Desk',style: TextStyle(fontWeight: FontWeight.bold),),
       ),
       SizedBox(height: 30,)
    ]),
    
  );
  
}
@override
  void initState() {
   databaseService.getquiz().then((val){
    setState(() {
      quizStream=val;
    });
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
         elevation: 0.0,
         systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent,
         statusBarIconBrightness: Brightness.dark
         ),
        centerTitle: true,
        title: appBar(context),
        
      ),
      body: SingleChildScrollView(child: Quizlist()),
      
    
    
    );
  }


}

class Quiztile extends StatelessWidget {
 final  String imageurl;
 final String title;
 final String desc;
 final String quizid;
Quiztile ({required this.imageurl, required this.title,required this.desc,required this.quizid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>PlayQuiz(quizid)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 150,
        child: Stack(  
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageurl , fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width-48,),
            ),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black26,)     ,   
              alignment: Alignment.center,
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text(desc,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
