import 'package:flutter_dev_template/db/sql/migrate_table_sqls.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:flutter_dev_template/utils/utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'sql/create_table_sqls.dart';

class DbManager {
  static const _VERSION = 1;

  static const _NAME = "app.db";

  factory DbManager() => _getInstance()!;

  static DbManager? _instance;

  static DbManager? get instance => _getInstance();

  DbManager._internal() {
    init();
  }

  static DbManager? _getInstance() {
    _instance ??= DbManager._internal();
    return _instance;
  }

  Database? _database;

  late String _path;


  ///初始化
  init() async {
    String directoryPath = await Utils.getLibraryPath();
    _path = join(directoryPath, _NAME);
    Log.saveLog("name: $_NAME,version: $_VERSION, path: $_path", tag: "数据库");
    _database = await openDatabase(_path, version: _VERSION,
        onCreate: (Database db, int version) async {
          //所有的sql语句
          CreateTableSqls sqlTables = CreateTableSqls();
          //所有的sql语句
          Map<String, String> allTableSqls = sqlTables.getAllTables();
          Log.map(allTableSqls);
          Batch batch = db.batch();
          allTableSqls.forEach((key, value) {
            batch.execute(value);
          });
          batch.commit(noResult: true, continueOnError: true).then((value) {});
          Log.d("create all table complete",tag: '数据库');
          Log.saveLog("创建所有表完成", tag: "数据库");
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          // 数据库表升级,注意看下述示例,分情况处理
          Log.saveLog("表升级：oldVersion: $oldVersion, newVersion:$newVersion",
              tag: "数据库");
          if (oldVersion <= 1) {
            // 第一种情况:表添加字段
            //   db.execute(MigrateTableSqls.addColumnExample);
            // 第二种情况: 表结构需要修改字段或删除字段
            var batch = db.batch();
            MigrateTableSqls.migrateTableExample(batch);
            await batch.commit(noResult: true, continueOnError: true).then((value) {});
          }
        });
    // List tableMaps = await _database
    //     .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    // Log.d('所有表:' + tableMaps.toString());
  }

  ///表是否存在
  isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database!.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res.isNotEmpty;
  }

  ///获取当前数据库对象
  Future<Database?> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  ///关闭
  close() {
    _database?.close();
    _database = null;
  }
}
