import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/core/constants/text.dart';
import 'package:recipbook/feature/home/repository/database.dart';
import 'package:recipbook/feature/recipe_detail/recipe_detail.dart';

class RecipeList extends StatefulWidget {
  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  Stream? recipeStream;

  @override
  void initState() {
    super.initState();
    loadRecipes();
  }

  loadRecipes() async {
    recipeStream = await DatabaseMethods().getallRecipe();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: recipeStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data.docs.isEmpty) {
          return const Center(child: Text("Рецепты не найдены"));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Количество элементов в ряду
            crossAxisSpacing: 10.0, // Расстояние между столбцами
            mainAxisSpacing: 10.0, // Расстояние между строками
            childAspectRatio: 0.8, // Соотношение сторон для элементов
          ),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                context.push(
                  RecipeDetali.path,
                  extra: {
                    'foodname': ds["Name"].toString(),
                    'image': ds["Image"].toString(),
                    'recipe': ds["Detail"].toString(),
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Фиксированная область для изображения
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Container(
                        height: 150, // Фиксированная высота
                        width: double.infinity,
                        color: Colors.grey[200], // Цвет фона на случай отсутствия изображения
                        child: Image.asset(
                          ds["Image"],
                          fit: BoxFit.cover, // Изображение занимает всю область
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        ds["Name"],
                        style: TextWidget.BoldFeildTextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
