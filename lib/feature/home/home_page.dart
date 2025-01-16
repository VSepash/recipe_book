import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/core/constants/text.dart';
import 'package:recipbook/feature/home/category_list.dart';
import 'package:recipbook/feature/home/recipe_list.dart';

class HomePage extends StatefulWidget {
  static const path = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          context.push('/addRecipe');
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 40.0),
        child: Column(
          children: [
            Header(),
            SizedBox(height: 20.0),
            CategoryList(),
            SizedBox(height: 20.0),
            Expanded(child: RecipeList()),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        children: [
          Text(
            "Найди любимое блюдо",
            style: TextWidget.BoldFeildTextStyle()
          ),
          
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "images/boy.jpg",
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
