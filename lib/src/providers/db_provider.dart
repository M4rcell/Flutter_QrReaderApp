
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider{

  // patron sigleton tener una sola instancia
  
  static Database _database;

    static final DBProvider db = DBProvider._();//constructor privado
  
    DBProvider._();

   // VALIDAR SI DB EXISTE
   Future<Database> get database async{
      if (_database!= null) {
        return _database;
        
      }
  
      _database= await initDB();
      return _database;
    }
    // CRAER TABLA
    initDB() async{
        
        Directory documentsDirectory = await getApplicationDocumentsDirectory();//directorio donde se encuentra el DB

        final path = join(documentsDirectory.path,'ScanDB.db');// nombre del archivo de DB

        return await openDatabase(
          path,
          version:1,
          onOpen: (db){},
          onCreate: (Database db,int version) async{
            await db.execute(
              'CREATE TABLE Scans('
              'id INTEGER PRYMARY KEY,'
              'tipo TEXT,'
              'valor TEXT'
              ')'
            );
          }
        );
  
  }

  // CREAR REGISTRO

/*    nuevoScanRaw( ScanModel nuevoScan) async{

     final db = await database; // esperar hasta que el bd este listo para ser usada

     final res = await db.rawInsert(
       "INSERT Into Scans (id,tipo,valor) "
       "VALUES (${nuevoScan.id},'${nuevoScan.tipo}','${nuevoScan.valor}')"
     );

     return res;// numero de inserciones realizadas

   } */

   nuevoScan(ScanModel nuevoScan) async{

     final db = await database;

     final res = await db.insert('Scan',nuevoScan .toJson());
     
     return res;
   }

   // SELECT - obtener informacion por id

   Future <ScanModel> getScanId(int id ) async{
     final db = await database;

     final res = await db.query('Scans',where:'id=?',whereArgs:[id ]);
     
     return res.isNotEmpty ? ScanModel.fromJson(res.first):null;
   }

   // SELECT - obtener toda la informacion
   Future <List<ScanModel>> getTodoScan( ) async{

     final db = await database;

     final res = await db.query('Scans');
     
     //si hay informacion 
     List<ScanModel> list = res.isNotEmpty 
                           ? res.map((c) => ScanModel.fromJson(c)).toList() //if devuelve toda la lista que hay
                           :[]; // else lista nulo

      return list;                  

   }

    // SELECT - obtener  informacion por  tipo
   Future <List<ScanModel>> getScanTipo(String tipo) async{

     final db = await database;

     final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");
     
     //si hay informacion 
     List<ScanModel> list = res.isNotEmpty 
                           ? res.map((c) => ScanModel.fromJson(c)).toList() //if devuelve toda la lista que hay
                           :[]; // else lista nulo

      return list;                  

   }

   // ACTUALIZAR REGISTROS

  Future<int> updateScan( ScanModel nuevoScan) async{

     final db = await database;

     final res =await db.update('Scans', nuevoScan.toJson(),where: 'id=?',whereArgs:[nuevoScan.id]);

     return res;
   }

   // ELIMINAR REGISTROS

  Future<int>deleteScanId( int id) async{

    final db = await database;
    final res = await db.delete('Scans', where:'id=?',whereArgs:[id]);

    return res;
  }

    // ELIMINAR TODO LOS REGISTROS

  Future<int>deleteScanAll() async{

    final db = await database;

    final res = await db.rawDelete('DELETE FROM Scans');

    return res;
  }

}