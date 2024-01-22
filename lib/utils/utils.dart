import 'package:flutter/material.dart';
import 'package:test_rnw/models/recipe.dart';
import 'package:test_rnw/widgets/recipe_dialog.dart';

showRecipeDialog(BuildContext context,[Recipe? recipe]){
  showDialog(
      context: context, builder:(context) => RecipeDialog(recipe: recipe));
}