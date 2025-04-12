import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planning du Salon"),
      ),
      body: Center(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: Image.asset("assets/images/damien.jpg"),
                title: Text("Damein Cavaillès (17h30 à 18H)"),
                subtitle: Text("git blame --no-offense"),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset("assets/images/defendintelligence.jpg"),
                title: Text("Defend Intelligence (18h à 18h30)"),
                subtitle: Text("À la découverte de l'IA générative"),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset("assets/images/lior.jpg"),
                title: Text("Lior Chamla (13h à 13h30)"),
                subtitle: Text("Le code Legacy"),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }
}