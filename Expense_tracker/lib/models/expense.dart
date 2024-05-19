import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

//TODO: 99. 預先定義允許值的組合, 儘管這些values並沒有以字串形式, 但他仍是合法的
enum Category { food, travel, leisure, work }

//TODO: 104. 1. 建立類別的圖示
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

///TODO: 98. 建立一個費用資料類別 Expense, 用來描述費用的資料結構
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //TODO 104. 2 安裝格式化日期套件
  String get formattedDate {
    return formatter.format(date);
  }
}

//TODO: 129. Create ExpenseBucket
class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  //TODO: 130. Create a constructor function for check expense of category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }
    return sum;
  }
}
