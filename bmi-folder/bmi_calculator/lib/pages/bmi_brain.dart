import 'dart:math';

class BmiBrain {
 
  BmiBrain({
    required this.height,
    required this.weight,
  });
    int height =0;
    int weight =19;
  late double _bmiResult;

//_bmiResult = weight / pow((height / 100), 2);

  String calculateBmi() {
    _bmiResult = weight / pow((height / 100), 2);
    return _bmiResult.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmiResult >= 25) {
      return 'Overweight';
    } else if (_bmiResult >= 18.5) {
      return 'Normal';
    } else {
      return 'UnderWeight';
    }
  }

  String getInterpretation() {
    if (_bmiResult >= 25) {
      return 'You have a higher than normal weight. Try to exercise more.';
    } else if (_bmiResult >= 18.5) {
      return 'You have a normal weight. Good Job!';
    } else {
      return 'you have a lower than normal body weight. you can eat a bit more.';
    }
  }
}
