import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  final events = [
    {
      "speaker" : "Damien Cavaillès",
      "date" : "17h30 à 18h",
      "subject" : "git blame --no-offense",
      "avatar" : "damien"
    },
    {
      "speaker" : "Defen Intelligence",
      "date" : "18h à 18h30",
      "subject" : "À la découverte de l'IA générative",
      "avatar" : "defendintelligence"
    },
    {
      "speaker" : "Lior Chamla",
      "date" : "13h30 à 14h",
      "subject" : "Le Low-code",
      "avatar" : "lior"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planning du Salon"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) { //dans le builder de chaque element on va récupérer le contexte et l'index

            final event = events[index];
            final avatar = event['avatar'];
            final speaker = event['speaker'];
            final subject = event['subject'];
            final date = event['date'];

            return Card(
              child: ListTile(
                leading: Image.asset('assets/images/$avatar.jpg'),
                title: Text('$speaker ($date)'),
                subtitle: Text('$subject'),
                trailing: Icon(Icons.more_vert),
              ),
            );
          },
        )
      ),
    );
  }
}
