
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider{

  // patron sigleton tener una sola instancia
  
  static Database _database;

    static final DBProvider db = DBProvider._();//constructor privado
  
    DBProvider._();
  
   Future<Database> get database async{
      if (_database!= null) {
        return _database;
        
      }
  
      _database= await initDB();
      return _database;
    }
    initDB() async{
        
        Directory documentsDirectory = await getApplicationDocumentsDirectory();//directorio donde se encuentra el DB

        final path = join(documentsDirectory.path,'ScanDB.db');// nombre del archivo de DB

        return await openDatabase(
          path,
          version:1,
          onOpen: (db){},
          onCreate: (Database db,int version) async{
            await db.execute(
              'CREATE TABLE Scan('
              'id INTEGER PRYMARY KEY,'
              'tipo TEXT,'
              'valor TEXT'
              ')'
            );
          }
        );
  
  }

}