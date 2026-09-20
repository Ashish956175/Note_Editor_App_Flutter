import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:sqflite/sqflite.dart';

class DbHelper {

  static const String dbname = "note_editor.db";
  static const String tablename = "notes";
  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnDesc = "description";
  static const String columnCurrentTime = "createdAt";

  DbHelper._();
  static DbHelper getInstance() => DbHelper._();
  Database? mdb;
  //intidb
  Future<Database> initDb() async {
    mdb ??= await openDb();
    return mdb!;

  }
  //opendb
  Future<Database> openDb() async{
    var appDir = await pathProvider.getApplicationDocumentsDirectory();
    String path =  join(appDir.path, dbname);
    return openDatabase(path, version: 1, onCreate: (db,_){
      db.execute("create table notes($columnId integer primary key autoincrement, $columnTitle text, $columnDesc text, $columnCurrentTime text)");
    });
  }
  //crude
  //add
  Future<bool> addNote({required String title, required String desc})async {
   Database db = await initDb();
   return await db.insert(tablename, {
     columnTitle: title,
     columnDesc: desc,
     columnCurrentTime: DateTime
         .now()
         .microsecondsSinceEpoch
         .toString()}) > 0;
 }
   //update
  Future<bool> updateNote({required int id, required String title, required String
  desc})async{
    Database db = await initDb();
    return await db.update(tablename, {
      columnTitle: title,
      columnDesc: desc,
    },where: '$columnId = ?' , whereArgs: [id])>0;
  }
  //fetching notes data
  Future<List<Map<String, dynamic>>> getAllNotes() async{
    Database db = await initDb();
    return await db.query(tablename);
  }
  //delete
 Future<bool> deleteNote({required int id})async {
   Database db = await initDb();
   return await db.delete(tablename, where: '$columnId = ?', whereArgs: [id]) > 0;
 }

}


