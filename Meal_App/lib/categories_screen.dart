import 'package:MealApp/categories_data.dart';
import 'package:MealApp/categories_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deli Meal'),
      ),
      body: GridView(
        padding: EdgeInsets.all(25),
        children: CATEGORY_DATA
            .map(
              (catData) => CategoryItem(
                catData.title,
                catData.color,
                catData.id,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
