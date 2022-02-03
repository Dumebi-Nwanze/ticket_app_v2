import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String ticket_id;
  final String? location;
  final String? destination;
  final String ticketCode;
  final DateTime timeBooked;
  final DateTime timeExpired;
  final String usedTicket;

  Ticket({
    required this.ticket_id,
    required this.location,
    required this.destination,
    required this.ticketCode,
    required this.timeBooked,
    required this.timeExpired,
    required this.usedTicket,
  });
  Map<String, dynamic> toJson() {
    return {
      "ticket_id": ticket_id,
      "location": location,
      "destination": destination,
      "ticketCode": ticketCode,
      "timeBooked": timeBooked,
      "timeExpired": timeExpired,
      "usedTicket": usedTicket,
    };
  }

  static Ticket fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Ticket(
        ticket_id: snap["ticket_id"],
        location: snap["location"],
        destination: snap["destination"],
        ticketCode: snap["ticketCode"],
        timeBooked: snap["timeBooked"].toDate(),
        timeExpired: snap["timeExpired"].toDate(),
        usedTicket: snap["usedTicket"]);
  }
}
