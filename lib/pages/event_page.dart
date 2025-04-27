import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolgen/models/event_model.dart';
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

    Future<void> showEventDetailsDialog(Event eventData) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            //backgroundColor: Colors.lightGreen.shade50,
            title: Text('Conférence ${eventData.speaker}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.asset("assets/images/${eventData.avatar}.jpg", height: 120,),
                  Text('Titre : ${eventData.subject}'),
                  Text('Speaker : ${eventData.speaker}'),
                  Text('Date de la conf : ${DateFormat.yMd().add_jm().format(eventData.timestamp.toDate())}'),
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
            List<Event> events = [];

            // snapshot.data!.docs.forEach( (element) { events.add(element); });
            for (var data in snapshot.data!.docs) {
              events.add(Event.fromData(data));
            }

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) { //dans le builder de chaque element on va récupérer le contexte et l'index

                final event = events[index];
                final avatar = event.avatar.toString().toLowerCase();
                final speaker = event.speaker;
                final subject = event.subject;
                final Timestamp timestamp = event.timestamp;
                final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());

                return Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/$avatar.jpg'),
                    title: Text('$speaker ($date)'),
                    subtitle: Text('$subject'),
                    trailing: IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () { showEventDetailsDialog(event); },
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
