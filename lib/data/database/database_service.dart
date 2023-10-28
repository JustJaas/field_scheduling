import 'package:field_scheduling/data/database/booking_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? database;

  Future<Database> get getDatabase async {
    if (database != null) {
      return database!;
    }
    database = await initialize();
    return database!;
  }

  Future<String> get fullPath async {
    const name = 'booking.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );

    return database;
  }

  Future<void> create(Database database, int version) async {
    await BookingDB().createTable(database);
  }
}
