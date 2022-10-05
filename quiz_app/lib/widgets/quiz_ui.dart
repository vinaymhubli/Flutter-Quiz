import 'package:flutter/material.dart';
class BodyTile extends StatefulWidget {
    final String option, description, correctAnswer, optionSelected;
    BodyTile({required this.option, required this.description, required this.correctAnswer, required this.optionSelected});

  @override
  State<BodyTile> createState() => _BodyTileState();
}

class _BodyTileState extends State<BodyTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(color: widget.optionSelected == widget.description
                        ? widget.description==widget.correctAnswer?Colors.green.withOpacity(0.9):
                        Colors.red.withOpacity(0.9):Colors.grey,width: 1.3),
                        color:widget.optionSelected==widget.description?widget.description==widget.correctAnswer?Colors.green.withOpacity(0.9):
                        Colors.red.withOpacity(0.9):Colors.white,
                        borderRadius: BorderRadius.circular(30)
            ),
            alignment: Alignment.center,
            child: Text("${widget.option}",style: TextStyle(color: widget.optionSelected==widget.description? 
            Colors.white:
            Colors.grey),),
          ),
          SizedBox(width: 10),
          Text(widget.description,style: TextStyle(color: Colors.black54,fontSize: 14),),
        ],
      ),
    );
  }
}