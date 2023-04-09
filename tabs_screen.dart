import 'package:flutter/material.dart';
import './favorite_screen.dart';
import './main_drawer.dart';
import './categories_screen.dart';
import './meal.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabScreen(this.favoriteMeals);
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
   late List<Map<String, Object>> pages;
  int _selectedPageIndex = 0;

  int seletedPageIndex = 0;

  @override
  void initState() {
    pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
        'page': FavoriteScreen(widget.favoriteMeals),
      'title': 'Your Favorite',
    },
  ];
    super.initState();
  }

  void selectPage(index) {
    setState(() {
      seletedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[seletedPageIndex]['title'].toString()),
      ),
      drawer: MainDrawer(),
      body: pages[seletedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        currentIndex: seletedPageIndex,
        type: BottomNavigationBarType.shifting,
        //iconSize: 2,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.purple,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
