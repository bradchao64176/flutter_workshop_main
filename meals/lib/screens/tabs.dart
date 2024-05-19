import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/screens/filters.dart';

//TODO: 177. global variable
const kInitialFilters = {
  Filter.glutenFree,
  Filter.lactoseFree,
  Filter.vegetarian,
  Filter.vegan,
};

//TODO: 166. Adding Tabs navigator
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreen();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  //
  final List<Meal> _favoritedMeals = [];

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    //TODO: 168. Add ScaffoldMessenger
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = _favoritedMeals.contains(meal);
    //TODO: 168. Add setState to sync meal
    if (isExisting) {
      setState(() {
        _favoritedMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoritedMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //TODO: 170. to close side drawer via identifier
  void _setScreen(String identifier) async {
    //TODO: 172. 加上這行後, 側邊攔就不會被打開了
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      //TODO: 176. await Navigator.of(context).push<Map<Filter, bool>>

      //TODO: 172. Replacing Screens
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      //print(result);
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoritesStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoritedMeals,
        onToggleFavorite: _toggleMealFavoritesStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      //TODO: 169. add a side drawer (widget) with a new built widget
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.start), label: 'Favorites'),
          ]),
    );
  }
}
