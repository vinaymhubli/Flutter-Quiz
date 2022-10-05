
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/bot/bot_screen.dart';
class BotHome extends StatefulWidget {
  BotHome({Key? key}) : super(key: key);

  @override
  State<BotHome> createState() => _BotHomeState();
}

class _BotHomeState extends State<BotHome> {
    DialogFlowtter? dialogFlowtter;
  final TextEditingController controller = TextEditingController();
  List<Map<String,dynamic>> messages=[];
  @override
  void initState() {
   DialogFlowtter.fromFile().then((instance) => dialogFlowtter=instance);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("HelpDesk",style: TextStyle(color: Colors.blue,fontSize: 35,fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages,)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
              color: Color.fromARGB(255, 4, 19, 157),
              child: Row(
                children: [
                  Expanded(child: TextField(
                  decoration: InputDecoration(hintText: "Ask your doubts",hintStyle: TextStyle(color: Colors.white) ),
                  
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                  )),
                  IconButton(onPressed: (){
                    sendMessage(controller.text);
                    controller.clear();
                  }, icon: Icon(Icons.send_rounded,color: Colors.white))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async{
    if(text.isEmpty){
      print("message is empty");
    }
    else{
      setState(() {
        reciveMessage(Message(text: DialogText(text: [text])),true);
      });
      DetectIntentResponse detectIntentResponse= await dialogFlowtter!.detectIntent(queryInput: QueryInput(text: TextInput(text: text)));
      if(detectIntentResponse==null)return;
      setState(() {
        reciveMessage(detectIntentResponse.message!);
      });
    }
  }
  reciveMessage(Message message,[bool isUsermessage=false]){
    messages.add({
      'message':message,
      'isUsermessage': isUsermessage
    });
  }
}