import 'package:flatter_quizzler/question.dart';
import 'package:flatter_quizzler/question_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  int scoreCount = 0;

  //creating an instance of QuestionBrain class
  //where all functionality stays
  QuestionBrain questionBrain = QuestionBrain();

  void checkAnswer(bool ans) {
    if (questionBrain.isQuestionsEnd()) {
      Alert(
        context: context,
        type: AlertType.success,
        title: 'Qizzler Finished!',
        desc: 'Score : $scoreCount out of ${questionBrain.getQuestionLength()}',
        buttons: [
          DialogButton(
            child: const Text(
              "Restart",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                scoreCount = 0;
                //questionBrain.isQuestionEnd = false;
                questionBrain.questionNumber = 0;
                scoreKeeper.clear();
                Navigator.pop(context);
              });
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      setState(() {
        if (questionBrain.getQuestionAns() == ans) {
          scoreCount++;
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        }
      });

      //after checking question change to the next answer
      questionBrain.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Score : $scoreCount',
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              questionBrain.getQuestionText(),
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
              checkAnswer(true);
            },
            child: const Text(
              'True',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            color: Colors.red,
            onPressed: () {
              setState(() {
                checkAnswer(false);
              });
            },
            child: const Text(
              'False',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
