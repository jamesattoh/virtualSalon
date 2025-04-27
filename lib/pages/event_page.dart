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
                      onPressed: () {  },
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
