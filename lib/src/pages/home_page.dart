
import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
       title:  Text("QR Scanner"),
       actions: <Widget>[
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
  
  _scanQR(){
    print("Scan QR ...");

    
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