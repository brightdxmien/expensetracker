import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDeleteExpense});
  final void Function(int) onDeleteExpense;
  final List<Expense> expenses;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  void _deleteExpense(index) {
    var _removedExpense = widget.expenses[index];
    var _removedIndex = index;
    // final expenseIndex = widget.expenses.indexOf(index);
    setState(() {
      widget.expenses.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Expense removed"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              widget.expenses.insert(_removedIndex, _removedExpense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.expenses.length,
        itemBuilder: (ctx, index) => ExpensesItem(
              onDismissed: () => _deleteExpense(index),
              widget.expenses[index],
            ));
  }
}
