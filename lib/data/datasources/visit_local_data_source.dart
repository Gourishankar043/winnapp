import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/visit.dart';
import '../models/visit_model.dart';

abstract class VisitLocalDataSource {
  Future<List<VisitModel>> getLocalVisits();

  Future<List<VisitModel>> getVisitLog();

  Future<void> insertLocalVisit(VisitModel visit);

  Future<bool> updateLocalVisit(VisitModel visit);

  Future<void> deleteLocalVisit(String id);

  Future<void> insertVisitLog(VisitModel visit);

  Future<bool> updateVisitLog(VisitModel visit);
}

class VisitLocalDataSourceImpl implements VisitLocalDataSource {
  static const String _databaseName = 'field_visit_log.db';
  static const int _databaseVersion = 1;

  static const String _localVisitsTable = 'local_visits';
  static const String _visitLogTable = 'visit_log';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final pathToDatabase = join(
      databasePath,
      _databaseName,
    );

    return openDatabase(
      pathToDatabase,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_localVisitsTable (
            id TEXT PRIMARY KEY,
            site_name TEXT NOT NULL,
            date TEXT NOT NULL,
            location TEXT NOT NULL,
            notes TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $_visitLogTable (
            id TEXT PRIMARY KEY,
            site_name TEXT NOT NULL,
            date TEXT NOT NULL,
            location TEXT NOT NULL,
            notes TEXT NOT NULL,
            created_at TEXT NOT NULL,
            stage TEXT NOT NULL,
            synced_at TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<VisitModel>> getLocalVisits() async {
    final db = await database;

    final rows = await db.query(
      _localVisitsTable,
      orderBy: 'created_at DESC',
    );

    return rows.map(_localRowToModel).toList();
  }

  @override
  Future<List<VisitModel>> getVisitLog() async {
    final db = await database;

    final rows = await db.query(
      _visitLogTable,
      orderBy: 'created_at DESC',
    );

    return rows.map(_logRowToModel).toList();
  }

  @override
  Future<void> insertLocalVisit(
      VisitModel visit,
      ) async {
    final db = await database;

    await db.insert(
      _localVisitsTable,
      _modelToLocalRow(visit),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<bool> updateLocalVisit(
      VisitModel visit,
      ) async {
    final db = await database;

    final affectedRows = await db.update(
      _localVisitsTable,
      _modelToLocalRow(visit),
      where: 'id = ?',
      whereArgs: [visit.id],
    );

    return affectedRows > 0;
  }

  @override
  Future<void> deleteLocalVisit(
      String id,
      ) async {
    final db = await database;

    await db.delete(
      _localVisitsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> insertVisitLog(
      VisitModel visit,
      ) async {
    final db = await database;

    await db.insert(
      _visitLogTable,
      _modelToLogRow(visit),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<bool> updateVisitLog(
      VisitModel visit,
      ) async {
    final db = await database;

    final affectedRows = await db.update(
      _visitLogTable,
      _modelToLogRow(visit),
      where: 'id = ?',
      whereArgs: [visit.id],
    );

    return affectedRows > 0;
  }

  Map<String, dynamic> _modelToLocalRow(
      VisitModel visit,
      ) {
    return {
      'id': visit.id,
      'site_name': visit.siteName,
      'date': visit.date.toIso8601String(),
      'location': visit.location,
      'notes': visit.notes,
      'created_at': visit.createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> _modelToLogRow(
      VisitModel visit,
      ) {
    return {
      'id': visit.id,
      'site_name': visit.siteName,
      'date': visit.date.toIso8601String(),
      'location': visit.location,
      'notes': visit.notes,
      'created_at': visit.createdAt.toIso8601String(),
      'stage': visit.stage.name,
      'synced_at': visit.syncedAt?.toIso8601String(),
    };
  }

  VisitModel _localRowToModel(
      Map<String, dynamic> row,
      ) {
    return VisitModel(
      id: row['id'] as String,
      siteName: row['site_name'] as String,
      date: DateTime.parse(
        row['date'] as String,
      ),
      location: row['location'] as String,
      notes: row['notes'] as String,
      createdAt: DateTime.parse(
        row['created_at'] as String,
      ),
      stage: VisitStage.draft,
      syncedAt: null,
    );
  }

  VisitModel _logRowToModel(
      Map<String, dynamic> row,
      ) {
    return VisitModel(
      id: row['id'] as String,
      siteName: row['site_name'] as String,
      date: DateTime.parse(
        row['date'] as String,
      ),
      location: row['location'] as String,
      notes: row['notes'] as String,
      createdAt: DateTime.parse(
        row['created_at'] as String,
      ),
      stage: VisitStage.values.byName(
        row['stage'] as String,
      ),
      syncedAt: row['synced_at'] != null
          ? DateTime.parse(
        row['synced_at'] as String,
      )
          : null,
    );
  }
}