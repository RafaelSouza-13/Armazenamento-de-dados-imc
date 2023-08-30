import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'imc_dao.dart';

Map<int, String> tableSqlScripts = {
  1: ImcDao.tableSqlImcScripts[0],
};

class SqliteDataBase {
  static Database? db;

  Future<Database> obterDataBase() async {
    if (db == null) {
      return await iniciarDataBase();
    }
    return db!;
  }

  Future iniciarDataBase() async {
    final String path = join(await getDatabasesPath(), 'database.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        for (int i = 1; i <= tableSqlScripts.length; i++) {
          await db.execute(tableSqlScripts[i]!);
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        for (int i = oldVersion + 1; i <= tableSqlScripts.length; i++) {
          await db.execute(tableSqlScripts[i]!);
        }
      },
      version: tableSqlScripts.length,
    );
  }
}
