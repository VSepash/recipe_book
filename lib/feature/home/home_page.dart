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
  bool isLoading = false;

  Future<void> loadData() async {
    setState(() {
      isLoading = true; // Устанавливаем состояние загрузки
    });

    try {
      // Имитация загрузки данных
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      print("Ошибка загрузки данных: $e");
    } finally {
      setState(() {
        isLoading = false; // Завершаем состояние загрузки
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData(); // Запускаем загрузку данных при инициализации
  }

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
      body: Stack(
        children: [
          Container(
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
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5), // Затемнение фона
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
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
            style: TextWidget.BoldFeildTextStyle(),
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
