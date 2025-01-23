import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRecipesPage extends StatelessWidget {
  static const String path = '/myRecipes';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Мои рецепты")),
        body: const Center(
          child: Text("Вы не авторизованы."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Мои рецепты")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Recipe")
            .where("uid", isEqualTo: user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data.docs.isEmpty) {
            return const Center(child: Text("У вас пока нет добавленных рецептов."));
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot recipe = snapshot.data.docs[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    recipe["Image"],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(recipe["Name"]),
                  subtitle: Text(recipe["Detail"]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
