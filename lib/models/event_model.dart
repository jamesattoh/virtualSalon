
import 'package:cloud_firestore/cloud_firestore.dart';

// on crée une sorte de moule pour représenter la notion d'event
class Event {
  final String subject;
  final String speaker;
  final String avatar;
  final String type;
  final Timestamp timestamp;

  Event ({
    required this.subject,
    required this.speaker,
    required this.avatar,
    required this.type,
    required this.timestamp
  });

  // création d'un outil permettant de transformer n'importe quel objet dynamic en un event : (une factory)
  factory Event.fromData(dynamic data) { // on passe ici toutes les données de la base qui sont des dynamics
    return Event( // on renvoie un Event au complet
        subject: data['subject'],
        speaker: data['speaker'],
        avatar: data['avatar'].toString().toLowerCase(),
        type: data['type'],
        timestamp: data['date']
    );
  }

}