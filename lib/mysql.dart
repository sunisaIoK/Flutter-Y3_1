import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '127.0.0.1', user = 'root', db = 'flutter_database';
  static int port = 3306;
  Mysql();

  Future<MySqlConnection> getconnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}
