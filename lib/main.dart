import 'package:flatter_quizzler/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizePage(),
          ),
        ),
      ),
    );
  }
}

class QuizePage extends StatefulWidget {
  const QuizePage({Key? key}) : super(key: key);

  @override
  _QuizePageState createState() => _QuizePageState();
}

class _QuizePageState extends State<QuizePage> {
  List<Widget> scoreKeeper = [
    /*const Icon(
      Icons.check,
      color: Colors.green,
    ),
    const Icon(
      Icons.close,
      color: Colors.red,
    ),*/
  ];

  List<Question> questions = [
    Question('Birds can fly.', true),
    Question('You can lead a cow down stairs not down stairs.', false),
    Question('Approximately one quarter of human bones are in feet.', true),
    Question('A slug\'s blood is green.', true),
  ];

  /*List<String> questionList = [
    'Birds can fly.',
    'You can lead a cow down stairs not down stairs.',
    'Approximately one quarter of human bones are in feet.',
    'A slug\'s blood is green.'
  ];

  List<bool> answerList = [true, false, true, true];*/

  int questionNumber = 0;

  void changeQuestions(bool ans) {
    setState(() {
      if (questions[questionNumber].answer == ans) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      if (questionNumber < questions.length - 1) {
        questionNumber++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Text(
              questions[questionNumber].questionText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: FlatButton(
            color: Colors.green,
            onPressed: () {
              changeQuestions(true);
            },
            child: const Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            color: Colors.red,
            onPressed: () {
              setState(() {
                changeQuestions(false);
              });
            },
            child: const Text(
              'False',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
