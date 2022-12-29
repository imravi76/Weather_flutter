import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/model/cities.dart';

import 'model/auto_cities.dart';

class DatabaseHelper{

  Database? database;

  Future initDB() async{

    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'database.db');
    var exists = await databaseExists(path);

    if(!exists){
      try{
        await Directory(dirname(path)).create(recursive: true);
      } catch(_){}

      var data = await rootBundle.load(join('assets', 'app_db.db'));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush:true);
      await openDatabase(path, onOpen: (path){
        path.execute("CREATE TABLE choices(c_id INTEGER PRIMARY KEY, country TEXT, name TEXT, lat REAL, lon REAL, defaults TEXT, sets TEXT)");
      });
    }
    return await openDatabase(path);
  }

  Future<Database?> openDb() async{

    if(database != null){
      return database;
    } else{
      database = await initDB();
      return database;
    }
  }

  /*Future<List<Cities>> getCities() async{
    final db = await openDb();
    var res = await db?.query("Cities");
    List<Cities> citiesMap = res!.map((e) => Cities.fromMap(e)).toList();
    return citiesMap;
  }

  Future<List<String>> selectItems() async {
    final db = await openDb();
    var usersData = await db?.query("Cities");
    return usersData!.map((Map<String, dynamic> row) {
      return row["name"] as String;
    }).toList();
  }*/

  Future<List<AutoCities>> selectedCities() async{
    final db = await openDb();
    var cityData = await db?.rawQuery("select c_id, lat, lon, country, name || ', ' || country as name from Cities");
    List<AutoCities> cityMap = cityData!.map((e) => AutoCities.fromMap(e)).toList();
    return cityMap;
  }

  Future<void> insertCities(Cities cities) async{
    final db = await openDb();
    await db?.insert('choices', cities.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    //db?.close();
  }

  Future<List<Cities>> getCities() async{
    final db = await openDb();
    var choice = await db?.query('choices');
    List<Cities> cityMap = choice!.map((e) => Cities.fromMap(e)).toList();
    return cityMap;
  }

  deleteCity(int c_id) async{
    final db = await openDb();
    return db?.delete("choices", where: "c_id = ?", whereArgs: [c_id]);
  }

  setCity(Cities cities) async{
    final db = await openDb();
    var response = await db?.update("choices", cities.toMap(), where: "c_id = ?", whereArgs: [cities.c_id]);
    return response;
  }

}
