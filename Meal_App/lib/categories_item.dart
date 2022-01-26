import 'package:flutter/material.dart';

import './category_meal_screen.dart';

//Catergory stateless widget
class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItem(this.title, this.color, this.id);

  // void selectCategory(BuildContext ctx) {          //navigate pages with navigator and material page route
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return CategoryMealScreen(id, title);
  //       },
  //     ),
  //   ); //#160
  // }

  void selectCategory(BuildContext ctx) {
    //navigate pages with navigator and material page route
    Navigator.of(ctx).pushNamed(
      //'/category-meals',
      CategoryMealScreen.routeName, // alternative of line above main #1
      arguments: {
        'id': id,
        'title': title,
      },
    ); //#162
  }

  @override
  Widget build(BuildContext context) {
    //special type of button widget that has a splash effect built in
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(
                  0.7), //was not able to set gradient based on data
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
