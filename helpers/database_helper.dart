import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:financecontrol/models/gasto.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'financecontrol.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE gastos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descricao TEXT,
            valor REAL
          )
        ''');
      },
    );
  }

  Future<int> insertGasto(Gasto gasto) async {
    final dbClient = await db;
    return await dbClient.insert('gastos', gasto.toMap());
  }

  Future<List<Gasto>> getGastos() async {
    final dbClient = await db;
    final maps = await dbClient.query('gastos');
    return maps.map((map) => Gasto.fromMap(map)).toList();
  }

  Future<int> deleteGasto(int id) async {
    final dbClient = await db;
    return await dbClient.delete('gastos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateGasto(Gasto gasto) async {
    final dbClient = await db;
    return await dbClient.update(
      'gastos',
      gasto.toMap(),
      where: 'id = ?',
      whereArgs: [gasto.id],
    );
  }

  Future<void> close() async {
    final dbClient = await db;
    await dbClient.close();
  }
}
