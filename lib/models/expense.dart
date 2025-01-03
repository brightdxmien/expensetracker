import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { Food, Travel, Leisure, Utilities }

const categoryIcons = {
  Category.Food: Icons.lunch_dining,
  Category.Leisure: Icons.movie,
  Category.Travel: Icons.flight_takeoff,
  Category.Utilities: Icons.lightbulb
};

class Expense {
  Expense({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }

  @override
  String toString() {
    return 'Expense(title: $title, category: $category, amount: $amount, date: $date)';
  }
}
