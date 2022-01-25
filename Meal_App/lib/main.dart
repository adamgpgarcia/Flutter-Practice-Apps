import 'package:MealApp/categories_screen.dart';
import 'package:MealApp/category_meal_screen.dart';
import 'package:flutter/material.dart';

import './categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.black,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,

              )
            ),
      ),
      //home: CategoriesScreen(),

      routes: {
        '/': (context) => CategoriesScreen(),   //Can use instead of home: CategoriesScreen(),   / = home
        //'/category-meals' : (context) => CategoryMealScreen(),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(),  // alternative of line above main #1     
      } //162
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deli Meals"),
      ),
      body: Center(
        child: Text('This is the body'),
      ),
    );
  }
}
