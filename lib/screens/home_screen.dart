import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_rnw/constant/routes.dart';
import 'package:test_rnw/controller/recipe_controller.dart';
import 'package:test_rnw/helper/db_helper.dart';
import 'package:test_rnw/helper/firebase_helper.dart';
import 'package:test_rnw/models/recipe.dart';
import 'package:test_rnw/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecipeController rc = Get.put(RecipeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(likedScreen);
              },
              icon: const Icon(Icons.favorite)),
          const SizedBox(width: 16)
        ],
      ),
      body: _buildRecipeList(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            rc.change(false);
            showRecipeDialog(context);
          },
          child: const Icon(Icons.add)),
    );
  }

  _buildRecipeList() {
    return Obx(
      () => ListView.builder(
        itemCount: rc.recipeList.length,
        itemBuilder: (context, index) {
          Recipe recipe = rc.recipeList[index];
          int id = recipe.id ?? 0;
          String title = recipe.title.toString();
          String desc = recipe.desc.toString();
          bool isLiked = recipe.isLiked == 1;
          return ListTile(
            title: Text(title),
            subtitle: Text(desc),
            leading: isLiked
                ? IconButton(
                    onPressed: () {
                      rc.toggleLike(id);
                    },
                    icon: const Icon(Icons.favorite))
                : IconButton(
                    onPressed: () {
                      FirebaseHelper.addLiked(Recipe(
                          id: id,
                          title: title,
                          desc: desc,
                          isLiked: isLiked == true ? 1 : 0));
                      rc.toggleLike(id);
                    },
                    icon: const Icon(Icons.favorite_outline)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      rc.change(true);
                      Recipe recipe = Recipe(
                          id: id,
                          title: title,
                          desc: desc,
                          isLiked: isLiked == true ? 1 : 0);
                      showRecipeDialog(context, recipe);
                    },
                    icon: const Icon(Icons.edit_outlined)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      DBHelper.deleteRecipe(id);
                    });
                  },
                  icon: const Icon(Icons.delete_outline),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
