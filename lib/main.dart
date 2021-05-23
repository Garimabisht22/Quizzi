import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
      body: ques(),
    ),
  ));
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class ques extends StatefulWidget {
  const ques({Key key}) : super(key: key);

  @override
  _quesState createState() => _quesState();
}

class _quesState extends State<ques> {
  List<Icon> scoreKeeper = [];
   int count=0;
  void checkAlert(){
    if(quizBrain.isFinished()==true)
    {
      Alert(
        context: context,
        title: 'Congrats!',
        desc: 'You\'ve completed the quiz. Your score is $count/14 ',
          image: Image.asset("assets/Success.png"),
          buttons: [
            DialogButton(
              color: Colors.pink,
              child: Text(
                'Restart',
                style: TextStyle(color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Dancing Script',
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreKeeper = [];
                  count=0;
                });
                Navigator.pop(context);
              },
            )
          ]
      ).show();
    }
  }
  void checkAns(bool userChoice) {
    bool correctAns = quizBrain.getQuesAns();
    setState(() {
      if(scoreKeeper.length>=14)
        checkAlert();
      else{
        if (correctAns == userChoice) {
          count++;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        }
        else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        checkAlert();
        quizBrain.nextQues();
    }});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipPath(
          clipper:
              CustomShape(), // this is my own class which extendsCustomClipper
          child: Container(
            child: Center(
              child: Text(
                'Quizzi',
                style: TextStyle(
                    fontSize: 40, fontFamily: 'Pacifico', color: Colors.white,

                ),
              ),
            ),
            height: 150,
            color: Colors.pink,
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuesText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.pink[600],
                  fontFamily: 'Lora',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 0, 0) ,
          child: Row(
            children: scoreKeeper,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'TRUE',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () {
                  checkAns((true));
                  print('Scorekeeper length is');
                 print(scoreKeeper.length);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                checkAns(false);
                print('Scorekeeper length is');
                print(scoreKeeper.length);
                },
              child: Text(
                'FALSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('-Made by Garima Bisht',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.pink,
                  shadows: [
                    Shadow(color: Colors.purple , offset: Offset(2,1), blurRadius:5)
                  ],
                  fontFamily: 'Dancing Script',
                  fontSize: 15,
                  color: Colors.pink,
                ),),
            ),
          ),
        ),

      ],
    );
  }
}
