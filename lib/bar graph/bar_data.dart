import 'package:expensetrackerapp/bar%20graph/individual_bar.dart';

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  //Initialize bar data
  void initializeBarData() {
    barData = [
      //sun
      IndividualBar(x: 0, y: sunAmount),

      //mon
      IndividualBar(x: 1, y: monAmount),

      //tue
      IndividualBar(x: 2, y: tueAmount),

      //wed
      IndividualBar(x: 3, y: wedAmount),

      //thurs
      IndividualBar(x: 4, y: thurAmount),

      //fri
      IndividualBar(x: 5, y: friAmount),

      //sat
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
