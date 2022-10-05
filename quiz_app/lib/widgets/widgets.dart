import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
  text: TextSpan(
    text: 'F',
    style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 7, 11, 206)),
    children: const <TextSpan>[
      TextSpan(text: 'lutter', style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 17, 95, 32))),
      TextSpan(text: ' Quiz', style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 28, 28, 28))),
      
    ],
  ),
);
}



Widget Button({required BuildContext context ,required String label,buttonwidth}){
  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 14),
                   
                    decoration: BoxDecoration(
                     color: Color.fromARGB(255, 23, 82, 131),
                     
                     borderRadius: BorderRadius.circular(40)
                    ),
                    width: buttonwidth!=null? buttonwidth:MediaQuery.of(context).size.width-28,
                    child: Text(label,style: TextStyle(fontSize: 20,color: Colors.white),),
                  );
}

