import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/core/constants/text.dart';
import 'package:recipbook/feature/recipe_detail/recipe_detail.dart';
import 'package:recipbook/feature/service/database.dart';

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
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.horizontal,
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
                margin: EdgeInsets.only(right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        ds["Image"],
                        height: 300,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      ds["Name"],
                      style: TextWidget.BoldFeildTextStyle(),
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
