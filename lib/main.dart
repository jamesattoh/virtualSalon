import 'package:dolgen/pages/event_page.dart';
import 'package:dolgen/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // un compteur qui sauvegardera le numero de la page sur laquelle on se trouvera
  int _currentIndex = 0;

  setCurrentIndex(index){
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) { // build assemble les elements mis à l'interieur de l'app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Salon Dolgen"),
          backgroundColor: Colors.lightGreen,
        ),
        body: [
          HomePage(),
          EventPage()
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index), // on aurait pu mettre onTap: (jugo) => setCurrentIndex(jugo),
          selectedItemColor: Colors.lightGreen,
          unselectedItemColor: Colors.black54,
          iconSize: 32,
          elevation: 10,
          backgroundColor: Colors.lightGreen.shade100,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Planning',
            ),
          ],
        ),
      ),
    );
  }
}
