import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{

   Future<void> addQuizData(Map <String,dynamic>quizData,  quizId)async{
    await FirebaseFirestore.instance.collection("FlutterQuiz").doc(quizId).set(quizData)
        .catchError((e) {
      print(e);
        });
   }

   Future<void> AddQuestion(Map<String,dynamic> QuestionData,  quizId)async{
await FirebaseFirestore.instance.collection("FlutterQuiz").doc(quizId).collection("QNA").add(QuestionData).catchError((e){
  print(e);
});

   }


getquiz()async{
  return await  FirebaseFirestore.instance.collection("FlutterQuiz").snapshots();
}

getquizdata(String quizId)async{
  return await FirebaseFirestore.instance.collection("FlutterQuiz").doc(quizId).collection("QNA").get();
}
}
