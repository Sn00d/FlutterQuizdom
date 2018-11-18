import 'package:flutter/material.dart';
import 'package:quizdom/ui/answer_button.dart';
import 'package:quizdom/ui/question_text.dart';
import 'package:quizdom/ui/correct_wrong_overlay.dart';
import 'package:quizdom/utils/question.dart';
import 'package:quizdom/utils/quiz.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new QuizPageState();
  }
}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human", false),
    new Question("Pizza is healthy", false),
    new Question("Flutter is awesome", true)]
  );
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        overlayVisible? new CorrectWrongOverlay(
            isCorrect,
            () {
              if(quiz.length == questionNumber){
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) =>  new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
                return;
              }
              currentQuestion = quiz.nextQuestion;
            this.setState(() {
              overlayVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
              });
             }) : new Container()
      ],
    );
  }
}