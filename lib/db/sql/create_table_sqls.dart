/// 数据库创建表相关
class CreateTableSqls {

  static const String createPersonTableSql = '''
    CREATE TABLE IF NOT EXISTS person (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    name TEXT,
    age INTEGER);
    ''';

  Map<String, String> getAllTables() {
    Map<String, String> map = <String, String>{};
    map['person'] = createPersonTableSql;
    return map;
  }
}
