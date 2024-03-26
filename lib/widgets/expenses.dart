import 'package:expense_tracker_app/widgets/expenses_list.dart/expenses.list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'flutter course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'grocery',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.food,
    )
  ];

  //@override
  // void initState() {
  //   super.initState();
  //   // Set the system status bar color
  //    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //     statusBarColor: Colors.blue, // Change this color as needed
  //   ));
  // }

  void _openAddExpense(){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (ctx)=>  NewExpense(onAddExpense:_addExpense),
    );
  }
  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          duration: const Duration(seconds: 4),
          content: const Text('Expense Deleted'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: (){
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                });
              }),
        ));
  }
  @override
  Widget build(BuildContext context) {

    Widget mainContent=const Center(
      child:
      Text('No Expenses Found, Start Adding New One'),
    );
    if(_registeredExpenses.isNotEmpty){
      mainContent= ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blue, // Same color as status bar
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:_openAddExpense,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Chart View Here....'),
            Expanded(
              child:mainContent,
            ),
          ],
        ),
      ),
    );
  }
}

