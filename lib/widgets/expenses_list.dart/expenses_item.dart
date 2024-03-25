import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.alarm),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(expense.date.toString()),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}