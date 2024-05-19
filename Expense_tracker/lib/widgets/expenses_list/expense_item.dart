import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    //TODO: 103. 2. 新建Card小部件, 將費用內容傳遞到Card的內容
    return Card(
      //TODO: 103. 3. 加入Padding間距與費用名稱
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        //child: Text(expense.title),
        //TODO: 103. 4. 這裡我們想要顯示金額, 日期與類別, 因此需要一個固定的Column來呈現數據
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(expense.title,
              //TODO. 126. 也可以在這裡設定Title 字形大小, 透過使用context
              style: Theme.of(context).textTheme.titleLarge
              //TODO: 126. 可以透過小部件微調而不影響整體主題
              //.copyWith(backgroundColor: Colors.white),
              ),
          const SizedBox(height: 4),
          Row(
            children: [
              //TODO: 103 5. 創建一個Row 來呈現amount
              //12.3433 ==> 12.34 小數後兩位
              //以下的擴展表示式可看作變數的一個值, 注入到字串中
              //呈現錢字符號前面要加上\ 作為跳脫字元
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              //TODO. 103. 7. 佔據所有剩餘空間
              const Spacer(),
              //TODO: 103. 6. 輸出類別和日期
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expense.formattedDate),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
