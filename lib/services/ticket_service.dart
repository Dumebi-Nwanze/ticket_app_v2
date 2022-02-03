import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_app_v2/custom_widgets/code_generator.dart';
import 'package:ticket_app_v2/models/ticket_model.dart';
import 'package:uuid/uuid.dart';

class TicketService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> bookTicket({
    required String locationValue,
    required String destinationValue,
  }) async {
    String result = "";
    String ticket_id = const Uuid().v1();
    Ticket ticket = Ticket(
      ticket_id: ticket_id,
      location: locationValue,
      destination: destinationValue,
      ticketCode: generateCode(),
      timeBooked: DateTime.now(),
      timeExpired: DateTime.now().add(const Duration(hours: 24)),
      usedTicket: "false",
    );
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("tickets")
          .doc(ticket.ticket_id)
          .set(ticket.toJson());
      result = "success";
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> useTicket(String id) async {
    String res = "";
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("tickets")
          .doc(id)
          .update({"usedTicket": "true"});
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
