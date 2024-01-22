import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_rnw/controller/recipe_controller.dart';
import 'package:test_rnw/helper/db_helper.dart';
import 'package:test_rnw/models/recipe.dart';

class RecipeDialog extends StatefulWidget {
  final bool isEdit;
  final Recipe? recipe;
  const RecipeDialog({super.key, this.isEdit = false, this.recipe});

  @override
  State<RecipeDialog> createState() => _RecipeDialogState();
}

class _RecipeDialogState extends State<RecipeDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  @override
  void initState() {
    if (widget.recipe != null) {
      nameController.text = widget.recipe!.title;
      desController.text = widget.recipe!.desc;
    }
    super.initState();
  }

  RecipeController rc = Get.put(RecipeController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Obx(() => Text(rc.isEdit.isTrue ? 'Edit Recipe' : 'Add Recipe',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter Name')),
          const SizedBox(height: 10),
          TextFormField(
              controller: desController,
              maxLines: 5,
              minLines: 1,
              decoration: const InputDecoration(labelText: 'Enter Recipe')),
          const SizedBox(height: 10),
          Obx(() => rc.isEdit.isFalse
              ? TextButton(
                  onPressed: () {
                    createRecipe();
                    Get.back();
                    Get.snackbar('Success', 'Recipe added successfully');
                  },
                  child: const Text('Submit'))
              : TextButton(
                  onPressed: () {
                    updateRecipe();
                    Get.back();
                    Get.snackbar('Success', 'Recipe update successfully');
                  },
                  child: const Text('Update')))
        ]),
      ),
    );
  }

  void createRecipe() async {
    await DBHelper.createRecipe(Recipe(
        title: nameController.text, desc: desController.text, isLiked: 0)).then((value)=>rc.getRecipe());
  }

  Future updateRecipe() async {
    await DBHelper.updateRecipe(widget.recipe!.id!, nameController.text,
        desController.text, widget.recipe!.isLiked).then((value)=>rc.getRecipe());
  }
}
