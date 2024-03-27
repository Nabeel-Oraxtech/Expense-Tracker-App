import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list.dart/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key,
    required this.expenses,
    required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(color: Theme.of(context).colorScheme.error.withOpacity(.75),
          margin:  EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),),
            
            key: ValueKey(expenses[index]),
            onDismissed: (direction){
              onRemoveExpense(expenses[index]);
            },
            child: ExpensesItem(expense: expenses[index])));
  }
}
