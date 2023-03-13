import 'package:flutter/material.dart';
import 'package:flutter_dev_template/db/db_manager.dart';
import 'package:flutter_dev_template/utils/log_utils.dart';
import 'package:sqflite/sqflite.dart';

/// db数据库常用操作
class DbDemoPage extends StatefulWidget {
  const DbDemoPage({Key? key}) : super(key: key);

  @override
  _DbDemoPageState createState() => _DbDemoPageState();
}

class _DbDemoPageState extends State<DbDemoPage> {
  final List<Person> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据库操作'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (_) {
              return <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: "增加",
                  child: Text("增加"),
                ),
                const PopupMenuItem<String>(
                  value: "查询",
                  child: Text("查询"),
                ),
              ];
            },
            onSelected: (String action) {
              switch (action) {
                case "增加":
                  _queryData(insertData: true);
                  break;
                case "查询":
                  _queryData();
                  break;
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            Person p = _list[index];
            return Dismissible(
              key: Key("${p.id}${p.name}"),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                _delPerson(p);
              },
              child: InkWell(
                  onTap: () {
                    // 点击Item
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: Divider.createBorderSide(context, width: 0.6),
                    )),
                    padding: const EdgeInsets.only(left: 16.0, right: 34.0),
                    height: 80.0,
                    child: Row(
                      children: <Widget>[
                        Opacity(
                            opacity:  0,
                            child: SizedBox(
                              width: 28.0,
                              child: Text("${p.id}"),
                            )),
                        Expanded(
                          child: Text("${p.id}        ${p.name}"),
                        )
                      ],
                    ),
                  )),
            );
          },
        ),
      ),
    );
  }

  Future<void> _delPerson(Person p) async{
    var db = await DbManager.instance!.getCurrentDatabase();
    db!.delete("person", where: "id=${p.id}");
    _list.remove(p);
    Log.json(_list);
    setState(() {});
  }

  Future<void> _queryData({bool insertData = false}) async {
    _list.clear(); // 数据重新初始化
    var db = await DbManager().getCurrentDatabase();
    Batch batch = db!.batch();
    int dataSize = insertData ? 10 : 0;
    // 初始化数据,批处理存入数据库
    for (int i = 0; i < dataSize; i++) {
      String name = "coffee $i";
      batch.insert(
        'person',
        Person(name: name).toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // 将数据存入数据库
    batch
        .commit(noResult: true, continueOnError: true)
        .then((value) => Log.d("insertItemList result: $value"));
    // 从数据库分页查询, 将数据同步到内存
    List<Map<String, dynamic>> maps = await db.query('person', orderBy: "id");
    List<Person> dataFromDb = List.generate(maps.length, (i) {
      return Person(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age']
      );
    });
    _list.addAll(dataFromDb);
    Log.json(_list);
    setState(() {

    });
  }

  @override
  void initState() {
    _queryData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Person {
  int? id;
  String? name;
  int? age;

  Person({this.id, this.name, this.age});

  @override
  String toString() {
    return "id: $id, name: $name, age: $age";
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
