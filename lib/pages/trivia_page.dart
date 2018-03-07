import 'package:flutter/material.dart';
import 'dart:async';
import '../pages/final_page.dart';
import '../utilities/get_data.dart';
import '../utilities/overlay.dart';
import '../utilities/data_types.dart';


class TriviaPage extends StatefulWidget {
  final int numberOfItems;
  final TriviaDifficulty difficulty;

  const TriviaPage({ Key key, this.numberOfItems : 10, this.difficulty : TriviaDifficulty.EASY}) : super( key: key );
    
  _TriviaPageState createState() => new _TriviaPageState();

}

class _TriviaPageState extends State<TriviaPage> {

  int _questionIndex;
  Future _data;
  List _triviaItems;
  int _totalNumberItems;
  TriviaDifficulty _difficulty;
  bool _lastQuestion;
  bool _feedBack;
  int _guessIndex;
  bool _result;
  int _total;
  int _correct;
  bool _loading;

 @override
  void initState() {
    super.initState();
    
    _totalNumberItems = widget.numberOfItems;
    _difficulty = widget.difficulty;
    _questionIndex = 0;
    _triviaItems = [];
    _feedBack = true;
    _loading = true;
    _result = false;
    _total = 0;
    _correct = 0;
    _data = new Data( numberOfItems: widget.numberOfItems, difficulty: widget.difficulty).getQuestions();
    
    _data.then((value) => handleValue(value))
      .catchError((error) => print('error'));

    _lastQuestion = true;
      
  }

  @override
  Widget build(BuildContext context) {
    if(_loading){
      return 
       new Material (
        child: new Container(
        color:Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Loading...',
                  style: new TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 25.0,  
                        ),
                  textAlign: TextAlign.center,
                 )
                
              ]
            )
          ),
        )
      );
        
    }
    if(_feedBack){
      return new Container(
        color:Colors.white,
        child: new AnswerOverlay(
           _result,
           (){
            setState(() {
                _feedBack = false;
                _questionIndex ++;
                _guessIndex = null;
              });
            },
             _correct,
             _total,
            
        ) 
      );
    }
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.only(top:20.0, right: 10.0, bottom:20.0, left:10.0),
                  child: new Text(
                  _triviaItems[_questionIndex].question,
                  style: new TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 30.0,
                          ),
                    textAlign: TextAlign.left,
                    ),
                ),

              new Container(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                
                shrinkWrap: true,
               
                itemBuilder: (_, int index) => 
                   new RadioListTile(
                      title: new Text(
                          _triviaItems[_questionIndex].answers[index].label, 
                          style: new TextStyle(
                            color: (_triviaItems[_questionIndex].answers[index].value == true) ? Colors.green : Colors.grey,
                            fontSize: 25.0,
                          ),
                      ),
                      value: index,
                      activeColor: Colors.grey.shade700,
                      groupValue: _guessIndex,
                      onChanged: (index){

                                  if(_lastQuestion) Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FinalPage(correct:_correct, total: _total, numberOfItems: widget.numberOfItems, difficulty: widget.difficulty,)));

                                  setState(() { 
                                    _guessIndex = index;
                                    _lastQuestion = (_questionIndex+2 >= _triviaItems.length) ? true : false; 
                                    _feedBack = true;
                                    _result = _triviaItems[_questionIndex].answers[index].value;
                                    _total++;
                                    if(_triviaItems[_questionIndex].answers[index].value) _correct++;
                                  });
                              },

                  ),
         
                itemCount: (_triviaItems == null) ? 0 : _triviaItems[_questionIndex].answers.length
              ),
            ),
          ]
        )
      ),
    );
  }


  handleValue(value){

    if (!mounted) return;

      setState(() {
        _triviaItems = value;
        _lastQuestion = (value.length <= 1) ? true: false;
        _feedBack=false;
        _loading=false;
      });

  }




}




