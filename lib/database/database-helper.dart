import 'dart:io';
import 'package:microblogging/database/database-commands.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "database.db";
  static final _databaseVersion = 1;

  // torna esta classe singleton
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(
    Database db,
    int version,
  ) async {
    DataBaseCommands dc = DataBaseCommands();

    print("Criando Banco");

    dc.onCreate().forEach((f) async {
      await db.execute(f);
      print(f);
    });
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    DataBaseCommands dc = DataBaseCommands();
    dc.onUpgrade().forEach((f) async {
      await db.execute(f);
    });
  }

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $table');
    return result.toList();
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.

  Future<List<Map<String, dynamic>>> deleteAll(String table) async {
    Database db = await instance.database;
    var result = await db.rawQuery('DELETE FROM $table');
    return result.toList();
  }

  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.

  Future<int> queryRowCount(table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.

  Future<int> update(String table, Map<String, dynamic> row, String where, List whereArgs) async {
    Database db = await instance.database;
    return await db.update(table, row, where: where, whereArgs: whereArgs);
  }

  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(String table, String where, List whereArgs) async {
    Database db = await instance.database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  // aqui executa a query bruta diretamento no banco
  Future<List<Map<String, dynamic>>> query(String sql, List whereArgs) async {
    Database db = await instance.database;
    return await db.rawQuery(sql, whereArgs);
  }

  // aqui executa a query bruta diretamento no banco
  Future<List<Map<String, dynamic>>> select(String table, String where, List whereArgs) async {
    Database db = await instance.database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }
}
