import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_new/model/event.dart';

class FirebaseUtils{

  static CollectionReference<Event> getEventsCollection(){
    return FirebaseFirestore.instance
        .collection("Events")
        .withConverter<Event>(
      fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, options) => event.toFireStore(),
    );
  }

  static Future<void> addEventToFireStore(Event event){
    //todo: 1- Create collection
    CollectionReference<Event> collectionRef = getEventsCollection();

    //todo: 2- create document
    DocumentReference<Event> docRef = collectionRef.doc();

    //todo: 3- assign auto doc id to event id
    event.id = docRef.id;   //todo: auto id

    //todo: 4- save data
    return docRef.set(event);
  }
}