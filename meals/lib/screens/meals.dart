import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

//TODO: 164. Add method for select meal
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealDetailsScreen(
        meal: meal,
        onToggleFavorite: onToggleFavorite,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //TODO: 159. 新增菜單
    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Uh oh...nothing here!',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'Try selecting a different category!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    ));

    //TODO: 159.如果有菜單內容
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        // itemBuilder: (ctx, index) => Text(
        //       meals[index].title,
        //     )
        //TODO: 162. 將菜單傳給MealItem
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          //TODO: 164. add selectMeal method
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }
    // TODO: implement build
    //TODO: 159. Build list view

    //TODO: 166. 加入判斷檢查是否有標題
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
