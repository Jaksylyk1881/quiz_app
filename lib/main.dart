import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        )
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int score=0;
  QuizBrain quizBrain = QuizBrain();

  void checkAnswer(bool userAns){
    setState(() {
      if(quizBrain.isFinished()){
        if(userAns==quizBrain.questions.answer){
          score++;
        }
        Alert(context: context, title: 'End of the Quiz',desc: 'Congratulations!\n Your Score: $score!').show();
        quizBrain.resetQuestionNumber();
        scoreKeeper.clear();
        score=0;
      }else{
        if(userAns==quizBrain.questions.answer){
          score++;
          scoreKeeper.add(const Icon(Icons.check,color: Colors.green,));
        }else{
          scoreKeeper.add(const Icon(Icons.close,color: Colors.red,));
        }
        quizBrain.nextQuestion();
      }
  });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Expanded(
          flex: 5,
          child: Center(
            child: Text(quizBrain.questions.question, textAlign: TextAlign.center,style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                checkAnswer(true);
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
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

