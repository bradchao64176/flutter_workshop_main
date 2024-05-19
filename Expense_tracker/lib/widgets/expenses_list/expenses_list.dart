import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    //TODO: 120. 費用移除
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  //TODO: 120. 費用移除
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // TODO: 101. 2 由於費用List可能是變動長度, 且可能會需要滾動列表, 因此這裡不建議使用Column小部件
    // 這裡我們使用ListView() widget, builder 是一個特殊的constructor function, 他預設是一個可滾動的列表
    // itemCount: 定義呈現多少列表項, 若為N個, 則後面的itemBuilder 會跑N次
    return ListView.builder(
      itemCount: expenses.length,
      //itemBuilder: (ctx, index) => Text(expenses[index].title),
      //TODO: 103 1. 新增ExpenseItem小部件
      itemBuilder: (ctx, index) => Dismissible(
        //TODO: 120. 增加Dismissible 可以用來移除費用 item小部件
        key: ValueKey(expenses[index]), //需要新增一個唯一的key 值
        //TODO: 126. 當你滑動刪除費用時, Dismissible 的background color 變成紅色
        background: Container(
          //TODO: 126. setup background color with opacity
          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          //margin: const EdgeInsets.symmetric(horizontal: 16),
          //TODO: 126. setup margin by align the theme of main.dart
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },

        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
