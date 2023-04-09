import 'package:flutter/material.dart';
import './dummy_data.dart';
import './category_item.dart';

//it is first page of the app
//in this page user see the Grid of categories
//or we can say List of categories

class CategoriesScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GridView(
      //padding is used for giving spacing in all direction

      padding: const EdgeInsets.all(15),
      children: DUMMY_CATEGORIES.map((catData) {
        //catData is used as a object of class Category
        // which is present in category.dart

        //and it fetching data from dummy_data.dart

        return CategoryItem(catData.id, catData.title, catData.color);
      }).toList(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //maxCrossAxisExtent: it is used to change the size of the box
        //in such a manner that we can align all boxses in 2 rows
        maxCrossAxisExtent: 200,

        //childAspectRatio is used to change the aspect ratio
        childAspectRatio: 3 / 2,
        //CROSS & MAIN axisspacing is used to create space between the boxses
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
