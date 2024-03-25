import 'package:expense_tracker_app/widgets/expenses_list.dart/expenses.list.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        category: Category.food)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const Text('Chart View HEre....'),
          Expanded(child: ExpensesList(expenses: _registeredExpenses)),
        ]),
      ),
    );
  }
}
