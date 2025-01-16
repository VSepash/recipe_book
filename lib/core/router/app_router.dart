import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/feature/add_recipe/page/add_recipe_page.dart';
import 'package:recipbook/feature/category/category.dart';
import 'package:recipbook/feature/home/home_page.dart';
import 'package:recipbook/feature/recipe_detail/recipe_detail.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: HomePage.path,
    routes: [
      // Home Page
      GoRoute(
        path: HomePage.path,
        builder: (context, state) => const HomePage(),
      ),
      
      // Category Recipes Page
      GoRoute(
        path: CategoryRecipe.path,
        builder: (context, state) {
          final category = state.uri.queryParameters['category']!;
          return CategoryRecipe(category: category);
        },
      ),

      // Recipe Detail Page
      GoRoute(
        path: RecipeDetali.path,
        builder: (context, state) {
          final data = state.extra as Map<String, String>;
          return RecipeDetali(
            foodname: data['foodname']!,
            image: data['image']!,
            recipe: data['recipe']!,
          );
        },
      ),
      GoRoute(
        path: AddRecipe.path,
        builder: (context, state) => const AddRecipe(),
      ),

    ],
  );
}
