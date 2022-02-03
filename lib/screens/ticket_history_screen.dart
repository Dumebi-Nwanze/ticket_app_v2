import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_v2/custom_widgets/code_generator.dart';
import 'package:ticket_app_v2/custom_widgets/ticket_card_widget.dart';
import 'package:ticket_app_v2/custom_widgets/ticket_history_card.dart';
import 'package:ticket_app_v2/models/ticket_model.dart';

class TicketHistoryView extends StatefulWidget {
  TicketHistoryView({Key? key}) : super(key: key);

  @override
  State<TicketHistoryView> createState() => _TicketHistoryViewState();
}

class _TicketHistoryViewState extends State<TicketHistoryView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .collection("tickets")
              .orderBy("timeBooked", descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              );
            }
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text(
                      "You don't have any tickets",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => TicketHistoryCard(
                      ticket: Ticket.fromSnap(snapshot.data!.docs[index]),
                    ),
                    itemCount: snapshot.data!.docs.length,
                  );
          }),
    );
  }
}
