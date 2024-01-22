import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_rnw/helper/db_helper.dart';
import 'package:test_rnw/models/recipe.dart';

class FirebaseHelper {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static void addLiked(Recipe recipe) {
    firestore
        .collection('recipes')
        .doc(recipe.id.toString())
        .set({'id': recipe.id, 'title': recipe.title, 'desc': recipe.desc});
  }

  static void removeLiked(int id) {
    firestore.collection('recipes').doc(id.toString()).delete();
    DBHelper.updateLiked(0, id);
  }
}
