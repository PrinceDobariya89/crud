import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_rnw/controller/recipe_controller.dart';
import 'package:test_rnw/helper/firebase_helper.dart';

class LikedRecipeScreen extends StatelessWidget {
  LikedRecipeScreen({super.key});

  final RecipeController rc = Get.put(RecipeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liked Recipe'),
        ),
        body: _buildRecipeList());
  }

  _buildRecipeList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text('No Liked Recipe Found'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            var doc = snapshot.data!.docs[index];
            return Card(
              child: ListTile(
                title: Text(doc['title']),
                subtitle: Text(doc['desc']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    FirebaseHelper.removeLiked(doc['id']);
                    rc.toggleLike(doc['id']);
                    Get.snackbar('Success', 'Recipe removed from favorites');
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
