
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'dart:developer' as developer;

import 'package:qrreaderapp/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex=0;
  ScanResult scanResult;
  String qrCodeResult ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
       title:  Text("QR Scanner"),
       actions: <Widget>[
         
        /* Text(scanResult.rawContent ?? "")
         , */
         IconButton(
           icon: Icon(Icons.delete_forever),
           onPressed: (){},

        )
       ],
      ),
      body: _callPage(currentIndex),

      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      

      
    );
  }
  
  Future _scanQR() async{

    // https://platzi.com/
    //geo:40.68675513364266,-73.60219374140628
    //await BarcodeScanner.scan()
     
     var  result= " https://platzi.com/";
     //setState(() => scanResult = result);

     //  String contenido = scanResult.rawContent ?? "";
      print("INFORMACION : $result");
       if(result != null)
       {
         final scan =ScanModel(valor:result); //se esta usando el modelo providers => export

         DBProvider.db.nuevoScan(scan);
      }
    /*   var result;
      try {
     
      result= await BarcodeScanner.scan();

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = '¡El usuario no otorgó permiso a la cámara!';
        });
      } else {
        result.rawContent = 'Error Desconocido: $e';
      }
      setState(() {
        scanResult = result;
      });
    } 
    if(scanResult != null)
    {
       print("INFORMACION 1: $result"  ); 
    }

    String prueba = scanResult.type?.toString()??"";
    String prueba1 = scanResult.rawContent ?? "";
    String prueba2 =scanResult.format?.toString() ?? "";
    String prueba3 =scanResult.formatNote ?? "";
    

    developer.log('log me', name: prueba1); 
     print("INFORMACION 1: $prueba1"  );  
        
    */

  }

  Widget _callPage(int paginaActual){ //evaluar en que pagina vas ha estar

    switch(paginaActual) {

      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default:
        return MapasPage();

    }
  }

  Widget _crearBottonNavigationBar(){

    return BottomNavigationBar(
      currentIndex: currentIndex,//saber que elemento esta activo
      onTap: (index){//se dispara cuando seleccionas 
      //index => cual se hizo click
         setState(() {
          currentIndex=index;
         });
      },
      items: [
        BottomNavigationBarItem(
        icon: Icon(Icons.map),
        title: Text('Mapas')
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.brightness_5),
        title: Text('Direcciones')
        ),
        
      ]
    );
  }
}