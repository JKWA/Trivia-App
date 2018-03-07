// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import './trivia_item.dart';
import './data_types.dart';


class Data {

  final int numberOfItems;
  final TriviaDifficulty difficulty;
  final String category;
  final String type;

  const Data( { Key key, this.numberOfItems, this.difficulty, this.category, this.type,});

   Future getQuestions() async {

     _getDifficulty(difficulty){

        switch(difficulty){
          case TriviaDifficulty.EASY:
          return 'easy';
          case TriviaDifficulty.MEDUIM:
          return 'medium';
          break;
          case TriviaDifficulty.HARD:
          return 'hard';
          break;
        }

     }

     var uri = new Uri.https(
        'opentdb.com', 
        '/api.php', 
        {
          'amount':  numberOfItems.toString(), 
          'type':'multiple',
          'difficulty':_getDifficulty(difficulty),
        });


    HttpClient httpClient = new HttpClient();

    String questionError;
    List triviaItems;
    

    try {
      triviaItems = [];
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        List results = data['results'];


        //using the index;
        for (var result in results){
          TriviaItem triviaItem = new TriviaItem(question:result['question'], correctAnswer:result['correct_answer'], incorrectAnswers:result['incorrect_answers']);
          triviaItems.add(triviaItem);
        }

        return triviaItems;
     
      } else {
        questionError = 'Trivia server error: please try again.';
        print(questionError);
        return [];
      }
    } catch (error) {
      print(error);
      questionError = 'Application error.';
      return [];
    }
  }
}
