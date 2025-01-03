import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/widgets/expenses.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense) onAddExpense;
  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  Category? _selectedCategory;
  DateTime? _selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<Expense> newExpense = [];
  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
    // print(selectedDate);
  }

  final dateformat = DateFormat.yMd();
  get formattedDate {
    return dateformat.format(_selectedDate!);
  }

  void _addExpense() {
    final String name = _nameController.text.trim();
    final Category? category = _selectedCategory;
    final double price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final DateTime? date = _selectedDate;

    if (name.isNotEmpty && category != null && price > 0 && date != null) {
      // setState(() {
      //   newExpense.add(Expense(
      //       title: name, category: category, amount: price, date: date));

      final newExpense = Expense(
        title: name,
        category: category,
        amount: price,
        date: date,
      );
      widget.onAddExpense(newExpense); // Pass the new expense back
      Navigator.of(context).pop();
      // }

      // );

      // Clear the text fields after adding the product
      _nameController.clear();
      _categoryController.clear();
      _priceController.clear();
      _dateController.clear();
      // Fluttertoast.showToast(
      //     msg: "Expense Added",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Expense Added')));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("Invalid Input"),
                content: Text(
                    "Please make sure all fields have been entered correctly"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Okay"))
                ],
              ));
    }
    print(newExpense);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: _priceController,
                  decoration: InputDecoration(hintText: "Amount"),
                ),
              ),
              Text(_selectedDate == null ? 'No date selected' : formattedDate),
              IconButton(
                  onPressed: _selectDate,
                  icon: Icon(Icons.calendar_month_rounded))
            ],
          ),
          Row(children: [
            DropdownButton(
                hint: Text("Category"),
                value: _selectedCategory,
                items: Category.values.map((Category category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (Category? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                }),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            TextButton(onPressed: _addExpense, child: Text("Save Expense")),
          ]),
        ],
      ),
    );
  }
}
