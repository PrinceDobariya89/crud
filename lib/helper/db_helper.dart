import 'package:sqflite/sqflite.dart';
import 'package:test_rnw/models/recipe.dart';

class DBHelper {
  static Future<void> createTable(Database database) async {
    await database.execute(
        'CREATE TABLE recipe(id INTEGER PRIMARY KEY,title TEXT,desc TEXT,isLiked BOOLEAN)');
  }

  static Future<Database> db() async {
    return openDatabase('recipe.db', version: 1,
        onCreate: (Database db, int version) async {
      await createTable(db);
    });
  }

  static Future<int> createRecipe(Recipe recipes) async {
    final db = await DBHelper.db();
    final data = {
      'title': recipes.title,
      'desc': recipes.desc,
      'isLiked': recipes.isLiked
    };
    print('data from create = $data');
    final id = await db.insert('recipe', data);
    return id;
  }

  static Future<List<Recipe>> getRecipe() async {
    final db = await DBHelper.db();
    List<Map<String, dynamic>> res = await db.query('recipe');
    print(res);
    return List.generate(
      res.length,
      (index) {
        return Recipe.fromMap(res[index]);
        // return Recipe(
        //   id: res[index]['id'],
        //   title: res[index]['title'],
        //   desc: res[index]['desc'],
        //   isLiked: res[index]['isLiked']);
      },
    );
  }

  static Future<int> updateLiked(int liked, int id) async {
    final db = await DBHelper.db();
    final data = {'isLiked': liked};
    final res =
        await db.update('recipe', data, where: 'id = ?', whereArgs: [id]);
    print("isLiked = $res");
    return res;
  }

  static Future<int> deleteRecipe(int id) async {
    final db = await DBHelper.db();
    final res = await db.delete('recipe', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  static Future<int> updateRecipe(
      int id, String name, String desc, int liked) async {
    final db = await DBHelper.db();
    final data = {'title': name, 'desc': desc, 'isLiked': liked};
    final res =
        await db.update('recipe', data, where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
