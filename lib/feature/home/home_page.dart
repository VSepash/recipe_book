import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/core/constants/text.dart';
import 'package:recipbook/feature/home/category_list.dart';
import 'package:recipbook/feature/home/recipe_list.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Для получения текущего пользователя

class HomePage extends StatefulWidget {
  static const path = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  User? currentUser;

  Future<void> loadData() async {
    setState(() {
      isLoading = true; // Устанавливаем состояние загрузки
    });

    try {
      currentUser = FirebaseAuth.instance.currentUser; // Получаем текущего пользователя
      await Future.delayed(const Duration(seconds: 2)); // Имитация загрузки данных
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
            context.push('/signoutscreen'); // Переход на экран выхода
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              context.push('/myRecipes'); // Переход на страницу "Мои рецепты"
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          context.push('/addRecipe'); // Переход на экран добавления рецепта
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 40.0), // верхний отступ
            child: Column(
              children: [
                Header(), // Заголовок
                SizedBox(height: 10.0), // отступ между заголовком и категориями
                CategoryList(), // Список категорий
                SizedBox(height: 6.0), // отступ между категориями и списком рецептов
                Expanded(child: RecipeList()), // Список всех рецептов
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
  const Header({Key? key}) : super(key: key);

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
          const Spacer(),
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
