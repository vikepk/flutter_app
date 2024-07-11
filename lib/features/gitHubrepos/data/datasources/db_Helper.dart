import 'package:assignmenr/features/gitHubrepos/data/models/gitHubRepo_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    //getting db if doesn't exists it creates one
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    //creates db
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'github_repos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    //creating a Table repos in github_repos.db Database
    await db.execute('''
      CREATE TABLE repos(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        stars INTEGER,
        ownerUsername TEXT,
        ownerAvatar TEXT,
        html_url TEXT,
        created_at TEXT,
        updated_at TEXT,
        pushed_at TEXT,
        watchers_count INTEGER,
        visibility TEXT,
        forks INTEGER,
        open_issues INTEGER,
        allow_forking INTEGER
      )
    ''');
  }

  Future<void> insertRepo(GitHubRepoModel repo) async {
    final db = await database;
    //Inserting into table repos
    await db.insert(
      'repos',
      repo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<GitHubRepoModel>> getRepos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('repos');
//get the repos from the table
    return List.generate(maps.length, (i) {
      return GitHubRepoModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllRepos() async {
    final db = await database;
    //delete all repos
    await db.delete('repos');
  }
}
