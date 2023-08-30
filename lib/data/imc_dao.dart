import 'package:sqflite/sqflite.dart';

import '../model/imc.dart';
import 'database.dart';

class ImcDao {
  static const List<String> tableSqlImcScripts = [
    """CREATE TABLE $_tableName(
      $_idImc INTEGER PRIMARY KEY AUTOINCREMENT,
      $_imc DOUBLE
    );"""
  ];
  static const String _tableName = 'Imc';
  static const String _idImc = 'idImc';
  static const String _imc = 'imc';

  Future<List<Imc>> pegarImcs() async {
    Database database = await SqliteDataBase().obterDataBase();
    List<Map<String, dynamic>> lista =
        await database.rawQuery("SELECT $_idImc, $_imc FROM $_tableName");

    return mapToImcs(lista);
  }

  List<Imc> mapToImcs(List<Map<String, dynamic>> lista) {
    List<Imc> imcs = [];
    for (var item in lista) {
      Imc imc = Imc.carregar(item[_idImc], item[_imc]);
      imcs.add(imc);
    }
    return imcs;
  }

  Future<void> adicionarImc(Imc imc) async {
    Database database = await SqliteDataBase().obterDataBase();
    database.rawInsert("INSERT INTO $_tableName ($_imc) values(?)", [
      imc.imc,
    ]);
  }

  Future<void> removerImc(int idImc) async {
    Database database = await SqliteDataBase().obterDataBase();
    database.rawDelete("DELETE FROM $_tableName WHERE $_idImc = ?", [
      idImc,
    ]);
  }
}
