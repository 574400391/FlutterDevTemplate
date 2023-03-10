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
  static String addColumnExample =
      "alter table person add column city Text default 'beijing'";

  /// 创建person表语句
  static const String createTableSqPerson = '''
    CREATE TABLE IF NOT EXISTS person (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    name TEXT,
    age INTEGER);
    ''';

  static void migrateTableExample(Batch batch) {
    String tempTableName = "local_invoice_temp";
    String tableName = "local_invoice";
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
    fpdm TEXT,
    fphm TEXT,
    fplxdm TEXT,
    yfpdm TEXT,
    yfphm TEXT,
    xsfsbh TEXT,
    xsfmc TEXT,
    gmfmc TEXT,
    sbbh TEXT,
    je TEXT,
    se TEXT,
    jshj TEXT,
    fpztbz TEXT,
    tqm TEXT,
    kprq TEXT,
    fpkjzt TEXT,
    gmfEmail TEXT,
    previewUrl TEXT);
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
    fpdm TEXT,
    fphm TEXT,
    fplxdm TEXT,
    yfpdm TEXT,
    yfphm TEXT,
    xsfsbh TEXT,
    xsfmc TEXT,
    gmfmc TEXT,
    sbbh TEXT,
    je TEXT,
    se TEXT,
    jshj TEXT,
    fpztbz TEXT,
    tqm TEXT,
    kprq TEXT,
    fpkjzt TEXT,
    gmfEmail TEXT,
    previewUrl TEXT,
    tag Text);
    ''');
    // 5. 临时表数据写入新表
    batch.execute('''
    INSERT INTO $tableName(id,fpdm,fphm,fplxdm,yfpdm,yfphm,xsfsbh,xsfmc,gmfmc,sbbh,je,se,jshj,fpztbz,tqm,kprq,fpkjzt,gmfEmail,previewUrl) SELECT * FROM $tempTableName;
    ''');
    // 6. 删除临时表
    batch.execute('''
    DROP TABLE $tempTableName
    ''');
     batch.commit();
  }
}
