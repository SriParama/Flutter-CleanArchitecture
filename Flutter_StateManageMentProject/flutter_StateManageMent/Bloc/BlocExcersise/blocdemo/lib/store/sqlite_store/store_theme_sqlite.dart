import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'theme.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE theme(id INTEGER PRIMARY KEY AUTOINCREMENT, theme TEXT)",
        );
      },
      version: 1,
    );
  }
}
