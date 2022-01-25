import 'package:flutter/material.dart';
import './categories_data.dart';


class CategoryMealScreen extends StatelessWidget {
  static const routeName = 'category-meals';      //other syntax of named routes main #1
  // final String categoryId;
  // final String categoryTitle;        //not need when using named routes

  // CategoryMealScreen(this.categoryId, this.categoryTitle);  
  
  
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;    //maps data that is sent in route
    final categoryTitle = routeArgs['title'];         //assigns data from route into variables
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle),),
      body: Container(
         child: Center(
           child: ListView.builder(itemBuilder: (ctx, index){
             return Text(categoryMeals[index].title);


           }, itemCount: categoryMeals.length,
           ),
       ),
    ),
    );
  }
}
