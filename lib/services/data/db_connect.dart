import 'db.dart';

class DbConnect {
  final Db db = Db();
  static final DbConnect _singleton = DbConnect._internal();
  factory DbConnect() => _singleton;

  DbConnect._internal();
}