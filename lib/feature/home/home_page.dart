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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            context.push('/signoutscreen');
          },
        ),
        title: Text(
          "Найди любимое блюдо",
          style: TextWidget.BoldFeildTextStyle(),
        ),
        centerTitle: true,
      ),
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
            margin: EdgeInsets.only(top: 20.0, left: 40.0), // верхний отступ
            child: Column(
              children: [
                Header(),
                SizedBox(height: 10.0), // отступ между заголовком и категориями
                CategoryList(),
                SizedBox(height: 10.0), // отступ между категориями и рецептом
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
