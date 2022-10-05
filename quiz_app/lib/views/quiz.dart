import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/services/cloud_database.dart';
import 'package:quiz_app/views/results.dart';
import 'package:quiz_app/widgets/quiz_ui.dart';
import 'package:quiz_app/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
 late final String quizId;
 PlayQuiz(this.quizId);

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}
 int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;



class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = DatabaseService();
    QuerySnapshot ?questionsnapshot;
  Questions getquestionsfromsnapshot(DocumentSnapshot questionsnapshot){
  Questions questions= Questions();
  questions.question=questionsnapshot["question"];
  List<String> Options = [
      questionsnapshot["option1"],
      questionsnapshot["option2"],
      questionsnapshot["option3"],
      questionsnapshot["option4"]
    ];
  Options.shuffle();
  questions.Option1=Options[0];
  questions.Option2=Options[1];
  questions.Option3=Options[2];
  questions.Option4=Options[3];
  questions.correctans=questionsnapshot["option1"];
  questions.ans=false;
  print(questions.correctans.toLowerCase());
  return questions;

}
  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getquizdata(widget.quizId).then((value){
   questionsnapshot=value;
   _notAttempted=0;
   _correct=0;
   _incorrect=0;
   total=questionsnapshot!.docs.length;
   print("$total this is the total");
   setState(() {
     
   });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.transparent,
         elevation: 0.0,
        //  iconTheme: IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: appBar(context),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                questionsnapshot==null?Container(child: Center(child: CircularProgressIndicator(color:Color.fromARGB(255, 23, 82, 131),strokeWidth: 5.5),),):
                ListView.builder(padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                  itemCount: questionsnapshot!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DifferentTile(questions:getquestionsfromsnapshot(questionsnapshot!.docs[index]),index: index,);
                    },
                  
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton( 
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Results(incorrect: _incorrect, total: total, correct: _correct,)));
        },

      ),
    );
  }
}

class DifferentTile extends StatefulWidget {
  final Questions questions;
  final int index;
  DifferentTile({required this.questions,required  this.index});

  @override
  State<DifferentTile> createState() => _DifferentTileState();
}

class _DifferentTileState extends State<DifferentTile> {
  String optionSelected="";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text("Q-${widget.index+1}${widget.questions.question}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
           SizedBox(height: 15,),
           GestureDetector(
            onTap: (){
              if(!widget.questions.ans){
                if(widget.questions.Option1==widget.questions.correctans){
             
             setState(() {
               optionSelected=widget.questions.Option1;
             widget.questions.ans=true;
             _correct=_correct+1;
             _notAttempted=_notAttempted-1;
             });
                }else{
                 
              setState(() {
                optionSelected=widget.questions.Option1;
             widget.questions.ans=true;
             _incorrect=_incorrect+1;
              _notAttempted=_notAttempted-1;
              });
    
                }
              }
            },
             child: BodyTile(option: "A", 
             description: "${widget.questions.Option1}", 
             correctAnswer: widget.questions.correctans, 
             optionSelected: optionSelected),
           ),
    
           SizedBox(height: 5,),
           GestureDetector(
           onTap: (){
            if(!widget.questions.ans){
                if(widget.questions.Option2==widget.questions.correctans){
            
             setState(() {
                optionSelected=widget.questions.Option2;
             widget.questions.ans=true;
             _correct=_correct+1;
             _notAttempted=_notAttempted+1;
             });
                }else{
                 
              setState(() {
                optionSelected=widget.questions.Option2;
             widget.questions.ans=true;
             _incorrect=_incorrect+1;
              _notAttempted=_notAttempted-1;
              });
    
                }
              }
           },
        
             child: BodyTile(option: "B", 
             description: "${widget.questions.Option2}", 
             correctAnswer: widget.questions.correctans, 
             optionSelected: optionSelected),
           ),
    
           SizedBox(height: 5,),
    
           GestureDetector(
            onTap: (){
              if(!widget.questions.ans){
                if(widget.questions.Option3==widget.questions.correctans){
             
             setState(() {
               optionSelected=widget.questions.Option3;
             widget.questions.ans=true;
             _correct=_correct+1;
             _notAttempted=_notAttempted+1;
             });
                }else{
                 
              setState(() {
                optionSelected=widget.questions.Option3;
             widget.questions.ans=true;
             _incorrect=_incorrect+1;
              _notAttempted=_notAttempted-1;
              });
    
                }
              }
            },
             child: BodyTile(option: "C", 
             description: "${widget.questions.Option3}", 
             correctAnswer: widget.questions.correctans, 
             optionSelected: optionSelected),
           ),
    
           SizedBox(height: 5,),
           GestureDetector(
            onTap: (){
              if(!widget.questions.ans){
                if(widget.questions.Option4==widget.questions.correctans){
            
             setState(() {
                optionSelected=widget.questions.Option4;
             widget.questions.ans=true;
             _correct=_correct+1;
             _notAttempted=_notAttempted+1;
             });
                }else{
                 
              setState(() {
                optionSelected=widget.questions.Option4;
             widget.questions.ans=true;
             _incorrect=_incorrect+1;
              _notAttempted=_notAttempted-1;
              });
    
                }
              }
            },
             child: BodyTile(option: "D", 
             description: "${widget.questions.Option4}", 
             correctAnswer: widget.questions.correctans, 
             optionSelected: optionSelected),
           ),
           SizedBox(height: 10,),
           Divider(thickness: 3,color: Colors.blue,)
          ],
        ),
      ),
    );
  }
}