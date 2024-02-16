import 'package:expensetrackerapp/components/expense_summary.dart';
import 'package:expensetrackerapp/components/expense_tile.dart';
import 'package:expensetrackerapp/data/expense_data.dart';
import 'package:expensetrackerapp/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//text controllers
  final newExpenseNameController = TextEditingController();
  //final newExpenseAmountController = TextEditingController();
  final newExpenseShillingController = TextEditingController();
  final newExpenseCentController = TextEditingController();

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Add new expense'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            //expense name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: "Expense name",
              ),
            ),
            Row(
              children: [
                //dollars
                Expanded(
                  child: TextField(
                      controller: newExpenseShillingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Shilings",
                      )),
                ),
                //cents
                Expanded(
                  child: TextField(
                      controller: newExpenseCentController,
                      decoration: InputDecoration(
                        hintText: "Cents",
                      )),
                ),
              ],
            ),

            // //expense amount
            // TextField(controller: newExpenseAmountController),
          ]),
          actions: [
            MaterialButton(
              onPressed: save,
              child: Text('Save'),
            ),
            MaterialButton(
              onPressed: cancel,
              child: Text('Cancel'),
            ),
          ]),
    );
  }

  //save
  void save() {
    //put dollars and cents together
    String amount =
        '${newExpenseShillingController.text}${newExpenseCentController.text}';
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseShillingController.clear();
    newExpenseCentController.clear();

    //newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: addNewExpense,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ListView(
            children: [
              //weekly summary
              ExpenseSummary(startOfWeek: value.startofweekDate()),

              const SizedBox(
                height: 20,
              ),

              //expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                ),
              ),
            ],
          )),
    );
  }
}
