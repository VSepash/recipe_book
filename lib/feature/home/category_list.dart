import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/feature/category/category.dart';
import 'package:recipbook/core/constants/text.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"title": "Суп", "image": "images/soup.jpg"},
    {"title": "Каша", "image": "images/kasha.jpg"},
    {"title": "Горячее", "image": "images/dop.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              context.push('${CategoryRecipe.path}?category=${category["title"]}');
            },
            child: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      category["image"]!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    category["title"]!,
                    style: TextWidget.LightFeildTextStyle(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
