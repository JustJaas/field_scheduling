import 'package:field_scheduling/data/database/booking_model.dart';
import 'package:field_scheduling/data/database/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class BookingDB {
  final tableName = 'bookings';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL,
      "name" TEXT NOT NULL,
      "date" TEXT NOT NULL,
      "weather" TEXT NOT NULL,
      "courtId" TEXT NOT NULL,
      PRIMARY KEY ("id" AUTOINCREMENT)
    );""");
  }

  Future<int> create({
    required String name,
    required String date,
    required String weather,
    required String courtId,
  }) async {
    final database = await DatabaseService().getDatabase;
    return await database.rawInsert(
      '''INSERT INTO $tableName (name, date, weather, courtId) VALUES (?, ?, ?, ?)''',
      [name, date, weather, courtId],
    );
  }

  Future<List<Booking>> fetchAll() async {
    final database = await DatabaseService().getDatabase;
    final bookings = await database.rawQuery(
      '''SELECT * from $tableName ORDER BY date ASC''',
    );
    return bookings
        .map((booking) => Booking.fromSqliteDatabase(booking))
        .toList();
  }

  Future<int> fetchByCourt(String courtId, String date) async {
    final database = await DatabaseService().getDatabase;
    final booking = await database.rawQuery(
        ''' SELECT COUNT(*) as count FROM $tableName WHERE courtId = ? AND date = ? ''',
        [courtId, date]);
    int count = Sqflite.firstIntValue(booking) ?? 0;
    return count;
    // return Booking.fromSqliteDatabase(booking.first);
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().getDatabase;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ? ''', [id]);
  }
}
