import 'package:flutter/material.dart';
import 'package:recipbook/core/constants/text.dart';

class RecipeDetali extends StatelessWidget {
  static const path = '/recipe';

  final String image;
  final String foodname;
  final String recipe;

  const RecipeDetali({
    Key? key,
    required this.foodname,
    required this.image,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  image,
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      child: Center(child: Text("Ошибка загрузки изображения")),
                    );
                  },
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 247, 247),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodname,
                    style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  Text("Рецепт:", style: TextWidget.BoldFeildTextStyle()),
                  const SizedBox(height: 10.0),
                  Text(recipe, style: TextWidget.BoldFeildTextStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
