import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'image_picker_util.dart';

class AddRecipe extends StatefulWidget {
  static const path = '/addRecipe';
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final List<String> recipeCategories = ['Суп', 'Каша', 'Горячее'];
  String? selectedCategory;
  String? selectedImageUrl;
  

  final imageUtil = ImagePickerUtil();

  Future<void> uploadItem() async {
    if (nameController.text.isNotEmpty &&
        detailController.text.isNotEmpty &&
        selectedCategory != null &&
        selectedImageUrl != null) {
      final recipe = {
        "Name": nameController.text,
        "Detail": detailController.text,
        "Image": selectedImageUrl,
        "Category": selectedCategory,
      };

      try {
        await FirebaseFirestore.instance.collection("Recipe").add(recipe);
        Fluttertoast.showToast(
          msg: "Рецепт был добавлен",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        setState(() {
          nameController.clear();
          detailController.clear();
          selectedImageUrl = null;
          selectedCategory = null;
        });
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Ошибка добавления рецепта",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Заполните все поля, выберите категорию и изображение.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Добавь рецепт"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Вернуться на предыдущую страницу
          },
        ),
      ),     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Добавить рецепт:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final imageUrl = await imageUtil.pickImage();
                  if (imageUrl != null) {
                    setState(() => selectedImageUrl = imageUrl);
                  }
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: selectedImageUrl != null
                      ? Image.network(selectedImageUrl!, fit: BoxFit.cover)
                      : const Icon(Icons.camera_alt_outlined, size: 50),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text("Название рецепта:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Введите название рецепта",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text("Категория:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              items: recipeCategories
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) => setState(() => selectedCategory = value),
              hint: const Text("Выберите категорию"),
              value: selectedCategory,
            ),
            const SizedBox(height: 20.0),
            const Text("Описание рецепта:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            TextField(
              controller: detailController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Введите описание рецепта",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: uploadItem,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Сохранить",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}