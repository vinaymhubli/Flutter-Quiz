
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/widgets.dart';
class Results extends StatefulWidget {
  final int total, correct, incorrect;
  Results({required this.incorrect,required  this.total, required this.correct,});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final controller=ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.play();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children:[ Scaffold(
        backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 8,),
              Text("You answered ${widget.correct} out of ${widget.total}"),
              
             SizedBox(height: 40,),
              GestureDetector(onTap: (){
                Navigator.pop(context);
              },
                child: Button(context: context, label: "Done",buttonwidth: MediaQuery.of(context).size.width/2),
              
                )
            ],
          ),
        ),
      ),
      ),
      ConfettiWidget(confettiController: controller,
      shouldLoop: true,
      blastDirectionality: BlastDirectionality.explosive,
      emissionFrequency: 0.19,
      numberOfParticles: 5,
     
      )
      ]
    );
  }
}