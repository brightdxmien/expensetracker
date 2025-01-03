import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [];
  //
  //
  // [
  //   Expense(
  //     amount: 23.54,
  //     date: DateTime.now(),
  //     title: "Transport",
  //     category: Category.Utilities,
  //   ),
  //   Expense(
  //     amount: 56.54,
  //     date: DateTime.now(),
  //     title: "Cinema",
  //     category: Category.Leisure,
  //   ),
  // ];
  void _deleteExpense(index) {
    final expenseIndex = registeredExpenses.indexOf(index);
    setState(() {
      registeredExpenses.remove(index); // Remove the item at the given index
      print(registeredExpenses);
    });

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Expense removed"),
    //   action: SnackBarAction(
    //       label: "Undo",
    //       onPressed: () {
    //         setState(() {
    //           registeredExpenses.insert(expenseIndex, index);
    //         });
    //       }),
    // ));
  }

  void _addExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: (Expense expense) {
              setState(() {
                registeredExpenses.add(expense);
                print(registeredExpenses);
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (registeredExpenses.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: _addExpenseOverlay, icon: Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      registeredExpenses.clear();
                    });
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          body: Center(
            child: Text(" Click + to add expenses"),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: _addExpenseOverlay, icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  setState(() {
                    registeredExpenses.clear();
                  });
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Column(
          children: [
            Chart(expenses: registeredExpenses),
            Expanded(
                child: ExpensesList(
              onDeleteExpense: _deleteExpense,
              expenses: registeredExpenses,
            ))
          ],
        ),
      );
    }
  }
}
