import 'package:flutter/material.dart';
import './dummy_data.dart';
import './tabs_screen.dart';
import './meal_detail_screen.dart';
import './category_meals_screen.dart';
import './categories_screen.dart';
import './filters_screen.dart';
import 'meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan']! && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Meals',
        theme: ThemeData(
          //Primary Swatch is used for changing appBar color
          // for all screen created
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,

          //canvas color is for the screen background color
          canvasColor: Color.fromRGBO(245, 243, 211, 1),

          //This code is commented because it is not working in new versions

          // textTheme: ThemeData.light().textTheme.copyWith(
          //   bodyText1: TextStyle(
          //     color: Color.fromRGBO(20, 51, 51, 1)
          //   ),

          //   bodyText2: TextStyle(
          //     color: Color.fromRGBO(20, 51, 51, 1)
          //   ),

          //   titleLarge: TextStyle(

          //   ),
          // ),
        ),

        //categories screen is created seperatly in categories_screen.dart
        //it is in the the form of grid view
        //home: CategoriesScreen(),
        routes: {
          '/': (ctx) => TabScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_availableMeals),
          MealDetailScreen.routeName: (ctx) =>
              MealDetailScreen(_toggleFavorite, _isMealFavorite),
          FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
        },
        onUnknownRoute: (setting) {
          return MaterialPageRoute(builder: ((ctx) => CategoriesScreen()));
        });
  }
}
