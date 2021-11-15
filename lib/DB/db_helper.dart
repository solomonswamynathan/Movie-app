import 'package:movies/model/fav.dart';
import 'package:movies/model/fav_movies.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = 'movie.db';
  static const _dbVersion = 1;

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const movieId = 'INTEGER PRIMARY KEY';
    const posterPath = 'TEXT NOT NULL';
    const movieTitle = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE ${FavMovies.tableName}(
      ${FavMovies.id} $movieId,
      ${FavMovies.posterPath} $posterPath, 
      ${FavMovies.movieTitle} $movieTitle
      )
      ''');
  }

  Future<void> addMovieToFav(Fav movie) async {
    final db = await instance.database;

    // final id = await db.insert(tableContacts, contact.toJson());
    final id = await db.rawInsert(
        'INSERT INTO ${FavMovies.tableName}(${FavMovies.id},  ${FavMovies.posterPath}, ${FavMovies.movieTitle}) VALUES(${movie.id}, "${movie.posterPath}", "${movie.title}")');
  }

  Future<List<Fav>> getAllMovies() async {
    final db = await database;
    final result = await db.query(FavMovies.tableName);
    return result.map((json) => Fav.fromJson(json)).toList();
  }

  Future<int> removeMovieFromFav(int id) async {
    final db = await instance.database;
    return await db.delete(FavMovies.tableName,
        where: '${FavMovies.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
