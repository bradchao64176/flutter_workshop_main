import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

  final void Function(Meal meal) onToggleFavorite;

  //TODO: 160. Add Navigator
  void _selectCategory(BuildContext context, Category category) {
    //TODO: 161.
    //如果有該類別的ID, return True, 否則為false
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // return a new Iterable list
    //導航到一個新的畫面 MealsScreen，並將相關的參數（例如類別標題和餐點列表）傳遞給該畫面以進行顯示
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              //TODO: 161: put Meals List here
              meals: filteredMeals,
              onToggleFavorite: onToggleFavorite,
            ))); //Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      //設定Grid的間距, 邊界不會疊在一起
      padding: const EdgeInsets.all(24),
      // TODO: 154.網格配置
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        //TODO: 156 Iterate all categories
        //availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        //from dummy_data.dart
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            //TODO: 160. Bind this method of categories
            onSelectCategory: () {
              //TODO: 161. add category parameter
              _selectCategory(context, category);
            },
          )
        // Text('1', style: TextStyle(color: Colors.white)),
        // Text('2', style: TextStyle(color: Colors.white)),
        // Text('3', style: TextStyle(color: Colors.white)),
        // Text('4', style: TextStyle(color: Colors.white)),
        // Text('5', style: TextStyle(color: Colors.white)),
        // Text('6', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
