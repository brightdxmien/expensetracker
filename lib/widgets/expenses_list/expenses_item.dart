import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class ExpensesItem extends StatefulWidget {
  const ExpensesItem(this.expense, {super.key, required this.onDismissed});

  final Expense expense;
  final VoidCallback onDismissed;

  @override
  State<ExpensesItem> createState() => _ExpensesItemState();
}

class _ExpensesItemState extends State<ExpensesItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.expense),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) => widget.onDismissed(),
      background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: Align(
              alignment: Alignment.centerLeft, child: Icon(Icons.delete))),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        child: Column(
          children: [
            Text(widget.expense.title),
            Row(
              children: [
                Text("\$${widget.expense.amount.toStringAsFixed(2)}"),
                Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[widget.expense.category]),
                    SizedBox(
                      width: 3,
                    ),
                    Text(widget.expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
