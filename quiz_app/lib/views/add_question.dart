import 'package:flutter/material.dart';
import 'package:quiz_app/services/cloud_database.dart';
import 'package:quiz_app/widgets/widgets.dart';
class AddQuestion extends StatefulWidget {
  

  @override
  State<AddQuestion> createState() => _AddQuestionState();
  final String quizId;
  AddQuestion( this.quizId);
}

class _AddQuestionState extends State<AddQuestion> {
  bool _isloading=false;

  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  late String question,option1,option2,option3,option4;
  uploaadQuizData()async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _isloading=true;
      });
      Map<String,String> questionMap={
        "question":question,
        "option1": option1,
        "option2": option2,
        "option3":option3,
        "option4":option4
              };
     await databaseService.AddQuestion(questionMap, widget.quizId).then((value){
  setState(() {
    _isloading= false;
  });
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
        title: appBar(context),
       iconTheme: IconThemeData(color: Colors.black),
        ),
        body: _isloading? Container(
          child: Center(child: CircularProgressIndicator(color:Color.fromARGB(255, 23, 82, 131),strokeWidth: 5.5),),
        ):     Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TextFormField(
              validator: (val)=>val!.isEmpty?"Enter Question":null,
              decoration: InputDecoration(  
                hintText: 'Question',
              ),
              onChanged: (val){question=val;},
            ),
        TextFormField(
              validator: (val)=>val!.isEmpty?'Enter Option':null,
              decoration: InputDecoration(  
                hintText: 'Option 1',
              ),
              onChanged: (val){option1=val;},
            ),
        TextFormField(
              validator: (val)=>val!.isEmpty?'Enter Option':null,
              decoration: InputDecoration(  
                hintText: 'Option 2',
              ),
              onChanged: (val){option2=val;},
            ),
        TextFormField(
              validator: (val)=>val!.isEmpty?"Enter Option":null,
              decoration: InputDecoration(  
                hintText: 'Option 3',
              ),
              onChanged: (val){option3=val;},
            ),
        TextFormField(
              validator: (val)=>val!.isEmpty?"Enter Option":null,
              decoration: InputDecoration(  
                hintText: 'Option 4',
              ),
              onChanged: (val){option4=val;},
            ),
            Spacer(),
            Row(
              children: [
               GestureDetector(onTap: (){Navigator.pop(context);},
                child: Button(context: context, label: "Done",buttonwidth: MediaQuery.of(context).size.width/2-36)),
               SizedBox(width: 25),
               GestureDetector( onTap: (){uploaadQuizData();},
                child: Button(context: context, label: "Add Quiz",buttonwidth: MediaQuery.of(context).size.width/2-36)),
               
        
         
        
        
        
        
        
              ],
            ),
           
        
              ],
            ),
          ),
        ),
    );
  }
}