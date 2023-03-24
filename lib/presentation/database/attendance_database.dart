import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    print('HoangNH: ${databasesPath}');
    String path = join(databasesPath, 'Attendance.db');
    print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS Attendance( 
                          id INTEGER PRIMARY KEY,
                          name TEXT NOT NULL,
                          masv TEXT NOT NULL,
                          time TEXT NOT NULL,
                          image TEXT NOT NULL,
                          magv TEXT NOT NULL,
                          mahocphan TEXT NOT NULL
                      );

                      //create more table here
                  
                  ''');
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getUser(int name) async {
    List<Map> maps =
        await db.query('Attendance', where: 'name = ?', whereArgs: [name]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
  Future<void> deleteDatabase(String path) =>
    databaseFactory.deleteDatabase(path);
}
