import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_rnw/helper/db_helper.dart';
import 'package:test_rnw/models/recipe.dart';

class RecipeController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  RxBool isEdit = false.obs;
  final recipeList = <Recipe>[].obs;
  RxInt isLiked = 1.obs;

  void change(bool status) {
    isEdit.value = status;
    update();
  }

  void toggleLike(int id) {
    bool liked = recipeList.firstWhere((p0) => p0.id == id).isLiked == 1;
    print(liked);
    if (liked) {
      isLiked.value = 0;
      DBHelper.updateLiked(0, id);
    } else {
      isLiked.value = 1;
      DBHelper.updateLiked(1, id);
    }
    getRecipe();
  }

  void getRecipe() async {
    recipeList.value = await DBHelper.getRecipe();
  }

  void deleteRecipe(int id){
    DBHelper.deleteRecipe(id);
    getRecipe();
  }

  @override
  void onInit() {
    getRecipe();
    super.onInit();
  }
}
