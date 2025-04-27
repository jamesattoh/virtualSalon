import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {


  @override
  Widget build(BuildContext context) {

    Future<void> showEventDetailsDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conférence'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset("assets/images/lior.jpg", height: 120,),
                  Text('Titre : Sujet de la conf.'),
                  Text('Speaker : Lior Chamla'),
                  Text('Date de la conf : 19 avril 2025 à 14h'),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.calendar_month),
                onPressed: (){}, 
                label: Text("Ajouter au calendrier")),
              TextButton(
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Events').snapshots(), // recuperation du flux de la collection
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) { // pour construire la vue
            if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return Text("Aucune conférence");
            }

            // si on arrive ici, c'est que la requete a abouti eet qu'il y a des donnees dans la réponse
            List<dynamic> events = [];

            // snapshot.data!.docs.forEach( (element) { events.add(element); });
            for (var element in snapshot.data!.docs) {
              events.add(element);
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) { //dans le builder de chaque element on va récupérer le contexte et l'index

                final event = events[index];
                final avatar = event['avatar'].toString().toLowerCase();
                final speaker = event['speaker'];
                final subject = event['subject'];
                final Timestamp timestamp = event['date'];
                final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());

                return Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/$avatar.jpg'),
                    title: Text('$speaker ($date)'),
                    subtitle: Text('$subject'),
                    trailing: IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () { showEventDetailsDialog(); },
                    ),
                  ),
                );
              },
            );
          },
        )
    );
  }
}
