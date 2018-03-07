import 'package:flutter/material.dart';
import './trivia_page.dart';
import '../utilities/data_types.dart';

// import 'dart:math';

class FinalPage extends StatelessWidget {

  final int correct;
  final int total;
  final int numberOfItems;
  final TriviaDifficulty difficulty;

  FinalPage({this.correct: 0, this.total: 0, this.numberOfItems: 10, this.difficulty: TriviaDifficulty.EASY});

  
  
  @override
  Widget build(BuildContext context) {

   int percent = (correct == 0 || total ==0) ? 0 : ((correct/total)*100).round();
  //  String percent = percentRaw.toString()+'%';
   
  

    return new Material(
      color: Colors.redAccent,
      child: new InkWell(
        onTap: () =>
          Navigator.of(context).push(
            new MaterialPageRoute(builder: (BuildContext context) => new TriviaPage(numberOfItems: numberOfItems, difficulty: difficulty,)
            )
        ),        
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Final Score", 
              style: new TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold,),
              ),
            new Text(" $percent% correct", style: new TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
            new Text("Tap for new game", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
          ]
        ),
      ),
    );
  }
}