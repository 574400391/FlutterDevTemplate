import 'package:sqflite/sqflite.dart';

/// 数据库表结构升级语句
/// 表增加字段:
///    alter table ${table_name} add column done Text default "";
/// 表字段修改或删除:
///   1. 新建临时表
///   2. 旧表数据导入新表
///   3. 删除旧表
///   4. 创建新表
///   5. 临时表数据写入新表
///   6. 删除临时表
class MigrateTableSqls {

  static void migrateTableExample(Batch batch) {
    String tempTableName = "person_temp";
    String tableName = "person";
    // oldVersion table person create sql:
    // '''
    //  CREATE TABLE IF NOT EXISTS person (
    //  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    //  name TEXT,
    //  age INTEGER);
    // ''';
    // 1. 新建临时表
    batch.execute('''
    CREATE TABLE IF NOT EXISTS $tempTableName (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    name TEXT,
    age INTEGER,
    address TEXT);
    ''');
    // 2. 旧表数据导入新表
    batch.execute('''
    INSERT INTO $tempTableName SELECT * FROM $tableName;
    ''');
    // 3. 删除旧表
    batch.execute('''
    DROP TABLE IF EXISTS $tableName
    ''');
    // 4. 创建新表
    batch.execute('''
    CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    name TEXT,
    age INTEGER,
    address TEXT);
    ''');
    // 5. 临时表数据写入新表
    batch.execute('''
    INSERT INTO $tableName(id, name, age, address) SELECT * FROM $tempTableName;
    ''');
    // 6. 删除临时表
    batch.execute('''
    DROP TABLE $tempTableName
    ''');
    batch.commit();
  }
}
