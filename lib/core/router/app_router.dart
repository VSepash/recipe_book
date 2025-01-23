import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipbook/feature/add_recipe/page/add_recipe_page.dart';
import 'package:recipbook/feature/auth/pages/reg_page.dart';
import 'package:recipbook/feature/auth/pages/sign_in_page.dart';
import 'package:recipbook/feature/auth/pages/sign_out_page.dart';
import 'package:recipbook/feature/category/category.dart';
import 'package:recipbook/feature/home/home_page.dart';
import 'package:recipbook/feature/my_recipe/my_recipe.dart';
import 'package:recipbook/feature/recipe_detail/recipe_detail.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: SigninScreen.path, 
    routes: [
      GoRoute(
        path: SigninScreen.path,
        builder: (context, state) => const SigninScreen(),
      ),
      GoRoute(
        path: HomePage.path,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: CategoryRecipe.path,
        builder: (context, state) {
          final category = state.uri.queryParameters['category']!;
          return CategoryRecipe(category: category);
        },
      ),
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
      GoRoute(
        path: SignoutScreen.path,
        builder: (context, state) => const SignoutScreen(),
      ),
      GoRoute(
        path: SignupScreen.path,
        builder: (context, state) => const SignupScreen(),
      ),
      //
      GoRoute(
        path: MyRecipesPage.path,
        builder: (context, state) => MyRecipesPage(),
      ),

    ],
  );
}
