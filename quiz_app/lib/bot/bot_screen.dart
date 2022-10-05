import 'package:flutter/material.dart';
class MessagesScreen extends StatefulWidget {
  final List messages;
  MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  

  @override
  Widget build(BuildContext context) {
    var w= MediaQuery.of(context).size.width;
    return ListView.separated(itemBuilder: (BuildContext context, int index) { return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: widget.messages[index]['isUsermessage']?MainAxisAlignment.end:MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 14,horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(widget.messages[index]['isUsermessage']?0:20),
              topLeft: Radius.circular(widget.messages[index]['isUsermessage']?20:0),
              
              ),
              color: widget.messages[index]['isUsermessage']?Colors.blue.shade600:Colors.blue.shade300
            ),
            constraints: BoxConstraints(maxWidth:w * 2/3),
            child: Text(widget.messages[index]['message'].text.text[0]),
          )
        ],
      ),
    ); }, 
    itemCount: widget.messages.length,
     separatorBuilder: (BuildContext context, int index)=>Padding(padding: EdgeInsets.only(top: 15)),
      
    );
  }
}