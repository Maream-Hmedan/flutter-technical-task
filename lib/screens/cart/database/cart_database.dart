import 'package:flutter_technical_task/screens/cart/model/cart_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  CartDatabase._();

  static final CartDatabase instance = CartDatabase._();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String databasePath = await getDatabasesPath();

    final String path = join(
      databasePath,
      'cart.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version,
      ) async {
    await db.execute('''
    CREATE TABLE cart(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      image TEXT NOT NULL,
      price REAL NOT NULL,
      quantity INTEGER NOT NULL
    )
  ''');
  }

  Future<void> insertCartItem(
      CartItem item,
      ) async {
    final Database db = await database;

    await db.insert(
      'cart',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<List<CartItem>> getCartItems() async {
    final Database db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'cart',
    );

    return result.map((item) {
      return CartItem.fromMap(item);
    }).toList();
  }
  Future<void> updateCartItem(
      CartItem item,
      ) async {
    final Database db = await database;

    await db.update(
      'cart',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
  Future<void> deleteCartItem(
      int id,
      ) async {
    final Database db = await database;

    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<void> clearCart() async {
    final Database db = await database;

    await db.delete(
      'cart',
    );
  }
}