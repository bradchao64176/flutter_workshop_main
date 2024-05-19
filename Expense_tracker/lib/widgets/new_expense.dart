import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/expense.dart';

//TODO: 141. cupertino 是iOS樣式語言的名稱
import 'package:flutter/cupertino.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //TODO: 109. 文字框控制器
  final _titleController = TextEditingController(); //文字框控制器用來處理輸入的資料處理
  final _amountController = TextEditingController();
  DateTime? _selectedDate; //TODO: 114. 設定變數 儲存日期
  Category _selectedCategory = Category.leisure;

  //TODO: 113. 選擇日期事件函數
  void _presentDatePicker() async {
    // TODO: 114. 加入async
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    //TODO: 113. Flutter 內建的日期模組
    final pickedDate = await showDatePicker(
      //TODO: 114. 加入await 等待輸入資料改變並儲存到該變數
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      //TODO: 141. iOS show alert dialog
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                  title: const Text('Invalid input'),
                  content: const Text(
                      'Please make sure a valid title, amount, date and category was entered.'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text('Okay')),
                  ]));
    } else {
      //TODO: 117. Flutter 內建函數showDialog, 螢幕上會彈出視窗
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay')),
          ],
        ),
      );
    }
  }

  //TODO: 116. add event function and validate input data is not null
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
        _amountController.text); //tryParse('Hello') => null if not integer
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //TODO: 141. for more readable with clear code
      _showDialog();
      //show error message

      return;
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    //TODO: 119. 確保overlay 被關閉, 再新增費用後
    Navigator.pop(context);
  }

  //用來告訴Flutter不用時要釋放掉文字框控制器, 否則不會刪除
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    // TODO: 140 Use layoutbuilder
    return LayoutBuilder(builder: (ctx, constrains) {
      final width = constrains.maxWidth;

      //TODO: 137. Replace SingleChildScrollView
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            //TODO: 119. 設定間距依序為左上右下, 上間距設為48可滿足大部分手機
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                //TODO: 140 判斷 寬度大小來決定要呈現的內容畫面
                if (width >= 600)
                  //TODO: 140. 水平排列Title 文字框與金額欄位
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: TextField(
                        //新增一個文字框
                        showCursor: true,
                        controller: _titleController,
                        //onChanged: _saveTitleInput, //當按下summit時觸發
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Title'), //新增標籤
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        //onChanged: _saveTitleInput, //當按下summit時觸發
                        //maxLength: 50,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'), //新增標籤
                        ),
                      ),
                    ),
                  ])
                else
                  TextField(
                    //新增一個文字框
                    showCursor: true,
                    controller: _titleController,
                    //onChanged: _saveTitleInput, //當按下summit時觸發
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'), //新增標籤
                    ),
                  ),

                //TODO: 140. 如果有足夠的空間, 將下拉選單與日期選擇小部件放在同一列
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          //TODO: 115. setup default value of dropdown box
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end, //TODO: 113. 控制水平靠右對齊
                          crossAxisAlignment:
                              CrossAxisAlignment.center, //TODO: 113. 內容居中對齊
                          //TODO: 113. 建立一個日曆 Icon button
                          children: [
                            //TODO: 114. 加入選擇的日期變數並輸出文字, 如果沒輸入...
                            Text(_selectedDate == null
                                ? "No date selected"
                                //TODO: 114. _selectedDate變數不能為空值, 在結尾加上! 來告訴Flutter 此變數不會是null
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed:
                                    _presentDatePicker, //TODO: 103. 日期選擇器
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          //onChanged: _saveTitleInput, //當按下summit時觸發
                          //maxLength: 50,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'), //新增標籤
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      //TODO: 113. 填充所有可用空間
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end, //TODO: 113. 控制水平靠右對齊
                          crossAxisAlignment:
                              CrossAxisAlignment.center, //TODO: 113. 內容居中對齊
                          //TODO: 113. 建立一個日曆 Icon button
                          children: [
                            //TODO: 114. 加入選擇的日期變數並輸出文字, 如果沒輸入...
                            Text(_selectedDate == null
                                ? "No date selected"
                                //TODO: 114. _selectedDate變數不能為空值, 在結尾加上! 來告訴Flutter 此變數不會是null
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed:
                                    _presentDatePicker, //TODO: 103. 日期選擇器
                                icon: const Icon(Icons.calendar_month)),
                          ],
                        ),
                      )
                    ],
                  ),
                //TODO: 115. 留些間距保持一定距離
                const SizedBox(
                  height: 16,
                ),

                //TODO: 140. 如果有足夠的空間, 將下Cancel button與Submit button小部件放在同一列
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      //TODO: 111. 新增一個Text Button
                      TextButton(
                        onPressed: () {
                          //TODO: 112. Add Navigator, 當按下取消按鈕時, 疊加層消失
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),

                      //108. 新增一個Save button (ElevatedButton), 當按下按鈕時觸發呼叫_saveTitleInput 函數, 並列印回傳值
                      ElevatedButton(
                        //TODO: 116. add event function called _submitExpenseData
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      //TODO: 115. 新增一個Dropdown button
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          //TODO: 115. setup default value of dropdown box
                          setState(() {
                            if (value == null) {
                              return;
                            }
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      //TODO: 111. 新增一個Text Button
                      TextButton(
                        onPressed: () {
                          //TODO: 112. Add Navigator, 當按下取消按鈕時, 疊加層消失
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),

                      //108. 新增一個Save button (ElevatedButton), 當按下按鈕時觸發呼叫_saveTitleInput 函數, 並列印回傳值
                      ElevatedButton(
                        //TODO: 116. add event function called _submitExpenseData
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
