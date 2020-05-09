
import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int curretIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center
        (child: Text('QR Scanner')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever), 
            onPressed: (){},
            
          ),
        ],
      ),
      body: _callPage(curretIndex),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColor,

      ),
      
    );
  }

  Widget _callPage( int paginaActual){
    
    switch(paginaActual){

      case 0: return MapaPage();
      case 1: return DireccionesPage();

      default:
       return MapaPage();

    }

  }

  Widget _crearBottomNavigatorBar() {

    return BottomNavigationBar(
      currentIndex: curretIndex,
      onTap: (index){

        setState(() {
          curretIndex =index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapa')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )
      ],
    );

  }
}