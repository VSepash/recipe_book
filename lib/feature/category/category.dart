import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipbook/core/constants/text.dart';
import 'package:recipbook/feature/recipe_detail/recipe_detail.dart';
import 'package:recipbook/feature/service/database.dart';

class CategoryRecipe extends StatefulWidget {
  static const path = '/category';
  final String category;
  const CategoryRecipe({required this.category, Key? key}) : super(key: key);

  @override
  State<CategoryRecipe> createState() => _CategoryRecipeState();
}

class _CategoryRecipeState extends State<CategoryRecipe> {
  Stream? categoryStream;

  getontheload() async {
    categoryStream = await DatabaseMethods().getCategoryRecipe(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allRecipe() {
    return StreamBuilder(
      stream: categoryStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetali(
                            foodname: ds["Name"],
                            image: ds["Image"],
                            recipe: ds["Detail"],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ds["Image"],
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          ds["Name"],
                          style: TextWidget.BoldFeildTextStyle(),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(child: allRecipe()),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
