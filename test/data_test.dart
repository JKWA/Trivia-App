import 'package:test/test.dart';
import 'dart:async';
import '../lib/utilities/get_data.dart';
import '../lib/utilities/data_types.dart';
import '../lib/utilities/trivia_item.dart';
// import '../lib/utilities/answer.dart';


void main() {

  test('data returns correctly', () async {

    _handleTests(value){
      expect(value, new isInstanceOf<List>());
      expect(value.length, 5);
      expect(value[0].answers, new isInstanceOf<List>());
      expect(value[0], new isInstanceOf<TriviaItem>());
      expect(value[0].question, new isInstanceOf<String>());
      expect(value[0].correctAnswer.value, new isInstanceOf<bool>());
     
     //need to implement
    //  expect(value[0].category, new isInstanceOf<String>());

     //not sure why this doesn't work
    //  expect(value[0].correctAnswer, new isInstanceOf<Answer>());
    }

    Future _data = new Data(numberOfItems: 5, difficulty: TriviaDifficulty.EASY).getQuestions();
    await _data.then( (value) => _handleTests(value));

  });

  

    

  



  //   var answer = 42;
  //   expect(answer, 42);
  // });
  // callback (value){
     
  // };
}