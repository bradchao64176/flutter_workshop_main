import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final void Function() onSelectCategory;

  @override
  //TODO: 156. create category item on a Screen
  Widget build(BuildContext context) {
    // TODO: implement build
    //TODO 157. setup InkWell for hit button and trigger event
    return InkWell(
      //TODO: 160 Bind onSelectCategory of categories here
      onTap: onSelectCategory,
      //TODO: 157. 按鈕長按會出現漸變色 highlight效果
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            //TODO: 157. 加了這個設定按鈕有圓角
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                //TODO: 156.設定漸層效果
                category.color.withOpacity(0.5),
                category.color.withOpacity(0.9)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
