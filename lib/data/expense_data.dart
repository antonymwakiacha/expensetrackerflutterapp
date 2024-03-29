import 'package:expensetrackerapp/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  //List of All expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
  }

  //delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
  }

  //get weekday (mon,tues,etc) from a dateTime object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get the date for the start of the week (sunday)
  DateTime startofweekDate() {
    DateTime? startofWeek;

    //get todays date
    DateTime today = DateTime.now();

    //go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startofWeek = today.subtract(Duration(days: i));
      }
    }

    return startofWeek!;
  }

  /*


  convert overall list of expenses into a daily expense summary

  e.g
  overallExpenseList=
  [
    [food,2023/01/30,$300],
    [milk,2023/01/30,$500],
    [pie,2023/01/06,$400],
    [water,2023/01/32,$200],
  ]

  ->
  
  DailyExpenseSummary=
  [
    [2023/01/30: $25],
    [2023/01/31: $30],
    [2023/02/01: $30],
    [2023/02/03: $30],
  ]
  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      //date (yymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
