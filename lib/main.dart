import 'package:dolgen/pages/add_event_page.dart';
import 'package:dolgen/pages/event_page.dart';
import 'package:dolgen/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // toutes les dépendances rattachées au projet seront initialisées avant de poursuivre la suite du code
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp( // initialisation de firebasse en fonction de la plateforme sur laquelle on se trouvrera
      options: DefaultFirebaseOptions.currentPlatform
  );

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

  setCurrentIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // build assemble les elements mis à l'interieur de l'app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:
              [
                Text("Accueil"),
                Text("Planning des conférences"),
                Text("Formulaire"),
              ][_currentIndex],
          backgroundColor: Colors.lightGreen,
        ),
        body: [HomePage(), EventPage(), AddEventPage()][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type:
              BottomNavigationBarType
                  .fixed, // la barre aura une largeur fixe et toutes les étiquettes seront toujours affichées sous leurs icônes
          currentIndex: _currentIndex,
          onTap:
              (index) => setCurrentIndex(
                index,
              ), // on aurait pu mettre onTap: (jugo) => setCurrentIndex(jugo),
          selectedItemColor: Colors.lightGreen,
          unselectedItemColor: Colors.black54,
          iconSize: 32,
          elevation: 10,
          backgroundColor: Colors.lightGreen.shade100,

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Planning',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Ajout'),
          ],
        ),
      ),
    );
  }
}
