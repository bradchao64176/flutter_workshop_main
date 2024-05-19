import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

//TODO: 97. 1.這裡要使用StatfulWidget用來更新新增費用之後回到主介面後的費用狀態更新
class Expenses extends StatefulWidget {
  //建立constructor function
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: 97. 2. implement createState, return _Expenses 物件
    return _ExpenseState();
  }
}

// TODO: 97. 4. State 物件要轉型成Expense物件
class _ExpenseState extends State<Expenses> {
  //TODO: 100. 1. 建立一個變數用來存放dummy date 費用清單
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category
          .work, //TODO: 100. 2. 已經import expense.dart, 可以直接取用Category enum
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category
          .leisure, //TODO: 100. 2. 已經import expense.dart, 可以直接取用Category enum
    ),
  ];

  //TODO: 118. 新增一個新增費用的方法
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //TODO: 120. 移除費用item
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    //TODO: 121. clear Snack Bar
    ScaffoldMessenger.of(context).clearSnackBars();
    //TODO: 121. ScaffoldMessenger, 當你反悔了, 可以取消的作用
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    //TODO: 139. 設定自動避開相機或麥克風的物件
    // showModalBottomSheet(
    //   useSafeArea: true,
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (ctx) => NewExpense(
    //     onAddExpense: _addExpense,
    //   ),
    // );

    //TODO: 106. 1. 使用Flutter內建函式
    //context 為一個帶有資料小部件的上下文
    final keyboardSpace = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      //TODO: 119. 若此參數設成true, 則overlay不會重疊到任何輸入視窗
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
          maxWidth: double.infinity, maxHeight: keyboardSpace - 24),
      //底下文字只是暫態, 後面會換掉
      //builder: (ctx) => Text('Modal bottom sheet'),
      //TODO: 107. corelated to nex expense
      builder: (ctx) => NewExpense(
          onAddExpense:
              _addExpense), //TODO: 118. Corelated to _addExpense method
    );
  }

  @override
  // TODO: 97. 3. implement build
  Widget build(BuildContext context) {
    //TODO: 136.
    //print(MediaQuery.of(context).size.width);
    //print(MediaQuery.of(context).size.height);

    final width = MediaQuery.of(context).size.width;

    //TODO: 121.show message once no expenses
    Widget mainContent = const Center(
      child: Text('No expenses found, Start adding some!'),
    );

    //TODO: 121.with mainContent assigns ExpensesList in case expense list is empty
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        //TODO: 120. 對齊UI,
        onRemoveExpense: _removeExpense,
      );
    }

    // TODO: 97. 4. 新建Scaffold小部件作為版型框架
    return Scaffold(

        //TODO: 105. 1. Add Toolbar with the Add button => Row()
        appBar: AppBar(
          //TODO: 141. Building Adative Widget
          centerTitle: false,
          //TODO 105. 3. 加入Text 小部件
          title: const Text('Flutter ExpenseTracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: Icon(Icons.add),
            )
          ],
        ),
        //TODO: 136. 判斷若是橫向模式, UI要跟著切換
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  //TODO: 101. 1. 創建一個單獨的費用小部件, 並將上述已經建好的費用List放到這個小部件
                  //但ExpensesList在Column中, 因此無法顯示正常, 在這裡使用擴展的小部件
                  Expanded(
                    child: mainContent,
                  ),

                  //Text('Expenses List...'),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  //TODO: 101. 1. 創建一個單獨的費用小部件, 並將上述已經建好的費用List放到這個小部件
                  //但ExpensesList在Column中, 因此無法顯示正常, 在這裡使用擴展的小部件
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
