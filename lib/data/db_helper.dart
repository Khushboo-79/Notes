import 'dart:ffi';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class dbHelper {

  // singleton

  dbHelper._();

  static final dbHelper getInstance = dbHelper._();
  //table note
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  Database? myDb;

  // db open(path if => exist then open else create db)

  Future<Database> getDb() async{

    myDb = myDb ?? await openDb();
    return myDb!;

    //or

    /*if(myDb != null){
      return myDb!;
    }
    else{
      myDb = await openDb();
      return myDb!;
    }*/
  }

  Future<Database> openDb() async {

    Directory appDir = await getApplicationDocumentsDirectory();

    String dpPath = join(appDir.path, "noteDB.db");

    return await openDatabase(dpPath, onCreate: (db, version) {

      // create all your tables
      // db.execute("create table note ( s_no integer primary key autoincrement, title text, desc text)");    or 
      
      db.execute("create table $TABLE_NOTE ( $COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)");

    }, version: 1);

  }



  // all queries

  // insertion

  Future<bool> addNote({required String mTitle, required String mDesc}) async{

    var db = await getDb();

    int rowsEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : mTitle,
      COLUMN_NOTE_DESC : mDesc
    });

    return rowsEffected>0;

  }

  // reading all data

  Future<List<Map<String, dynamic>>> getAllNotes() async{

    var db = await getDb();

    // select * from note
    List<Map<String, dynamic>> mdata = await db.query(TABLE_NOTE);

    return mdata;

  }

  // update data

  Future<bool> updateNote({required String mTitle, required String mDesc, required int sno}) async{
    var db = await getDb();

    int rowsEffected = await db.update(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : mTitle,
      COLUMN_NOTE_DESC : mDesc
    },
      where: "$COLUMN_NOTE_SNO = $sno"
    );

    return rowsEffected>0;
  }

  // delete note

  Future<bool> deleteNote({required int sno}) async{
    var db = await getDb();
    
    int rowsEffected = await db.delete(TABLE_NOTE, where: "$COLUMN_NOTE_SNO = ?", whereArgs: ['$sno']);

    return rowsEffected>0;

  }
}

