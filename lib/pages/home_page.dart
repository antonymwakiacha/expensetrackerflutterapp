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
  final newExpenseAmountController = TextEditingController();

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
            ),

            //expense amount
            TextField(controller: newExpenseAmountController),
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
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
  }

  //cancel
  void cancel() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: Icon(Icons.add),
      ),
      body:ListView.builder(itemBuilder: (context,index)=> ListTile(title:Text()), ),
    );
  }
}
