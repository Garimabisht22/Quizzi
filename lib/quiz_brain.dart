import 'question.dart';
class QuizBrain{
  int _queryNo=0 ;
  List<Question> _query =[
    Question('Approximately one quarter of human bones are in the feet.', true), //0
    Question('Dead people can not get goose bumps.', false),  //1
    Question('Lightning never strikes in the same place twice.', false),  //2
    Question('If you cry in space the tears just stick to your face.', true), //3
    Question('If you cut an earthworm in half, both halves can regrow their body.', false), //4
    Question('Humans can distinguish between over a trillion different smells.', true), //5
    Question('You taste different flavours with different parts of your tongue.', false),   //6
    Question('You do not use only 10% of your brain. You use 100%.', true),   //7
    Question('There are more cells of bacteria in your body than there are human cells.', true),  //8
    Question('Birds are dinosaurs.', true),     //9
    Question('fire typically spreads downhill more quickly than uphill.', false), //10
    Question('Humans have waterproofing proteins in their skin to help prevent water loss.', true),  //11
    Question('It is possible for hot water to freeze more quickly than cold water.', true), //12
    Question('Elephants can hear through their feet.', true)//13,
  ];
  bool isFinished(){
    if(_queryNo >=_query.length-1) {
      print('query is finished');
      print('query no is $_queryNo');
      return true;
    }
    else
      return false;
  }
  void reset(){
    _queryNo=0;
  }
  void nextQues(){
    if (_queryNo<_query.length-1) {
      _queryNo++;
    }
  }
  String getQuesText(){
    return _query[_queryNo].quesText;
  }
  bool getQuesAns(){
    return _query[_queryNo].quesAns;
  }
}